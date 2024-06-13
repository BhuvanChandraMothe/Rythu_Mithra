import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rythu_mithra/components/comment_button.dart';
import 'package:rythu_mithra/components/comments.dart';
import 'package:rythu_mithra/components/delete_post_button.dart';
import 'package:rythu_mithra/components/like_button.dart';
import 'package:rythu_mithra/helper/time_helper_methods.dart';

class ForumPosts extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;

  const ForumPosts({
    super.key,
    required this.message,
    required this.user,
    required this.likes,
    required this.time,
    required this.postId,
  });

  @override
  State<ForumPosts> createState() => _ForumPostsState();
}

class _ForumPostsState extends State<ForumPosts> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void addComment(String commentText) {
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now()
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(
            hintText: 'Write a comment...',
          ),
        ),
        backgroundColor: Colors.grey,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              addComment(_commentTextController.text);
              Navigator.pop(context);
              _commentTextController.clear();
            },
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void deletePost() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              final commentDocs = await FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(widget.postId)
                  .collection('Comments')
                  .get();

              for (var doc in commentDocs.docs) {
                await FirebaseFirestore.instance
                    .collection('User Posts')
                    .doc(widget.postId)
                    .collection('Comments')
                    .doc(doc.id)
                    .delete();
              }

              FirebaseFirestore.instance
                  .collection('User Posts')
                  .doc(widget.postId)
                  .delete()
                  .then((value) => print('Post deleted'))
                  .catchError(
                      (error) => print('Failed to delete post: $error'));

              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 214, 219, 214),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: const Offset(2.0, 2.0),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.message,
                      style: const TextStyle(fontSize: 20),
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(' - '),
                        Flexible(
                          child: Text(
                            widget.user,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 39, 39, 39)),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Text(' • ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 39, 39, 39))),
                        Text(widget.time,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 39, 39, 39))),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: [
                LikeButton(isLiked: isLiked, onTap: toggleLike),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.likes.length.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ]),
              const SizedBox(
                width: 10,
              ),
              Column(children: [
                CommentButton(onTap: showCommentDialog),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  '0',
                  style: TextStyle(color: Colors.grey),
                ),
              ]),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comments")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;

                    final commentText = commentData["CommentText"] as String?;
                    final commentedBy = commentData["CommentedBy"] as String?;
                    final commentTime =
                        commentData["CommentTime"] as Timestamp?;

                    if (commentText == null ||
                        commentedBy == null ||
                        commentTime == null) {
                      return Container();
                    }

                    return Comment(
                      text: commentData["CommentText"],
                      username: commentData["CommentedBy"],
                      time: formatDate(commentData["CommentTime"] ?? 'No time'),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
