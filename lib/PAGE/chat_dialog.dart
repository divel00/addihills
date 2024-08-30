import 'package:flutter/material.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class MessageDialog extends StatefulWidget {
  const MessageDialog({Key? key}) : super(key: key);

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  static List<Map<String, dynamic>> messages = [];
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  static bool _hasInitialMessage = false; // Changed to static

  @override
  void initState() {
    super.initState();
    initializeDialogFlow();
    _addInitialMessageOnce();
  }

  void initializeDialogFlow() async {
    dialogFlowtter = await DialogFlowtter.fromFile();
  }

  void _addInitialMessageOnce() {
    if (!_hasInitialMessage) {
      setState(() {
        messages.add({
          'message': Message(text: DialogText(text: ['Hello! How can I assist you today?'])),
          'isUserMessage': false
        });
        _hasInitialMessage = true;
      });
    }
  }

  void _resetConversation() {
    setState(() {
      messages.clear();
      _hasInitialMessage = false;
      _addInitialMessageOnce(); // Re-add initial message on reset
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dialogWidth = screenSize.width * 0.90;
    final dialogHeight = screenSize.height * 0.80;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: dialogWidth,
        height: dialogHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: MessagesScreen(
                messages: messages,
                scrollController: _scrollController,
              ),
            ),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF3D3D3D),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'RequEase',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: _resetConversation,
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF3D3D3D),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                hintStyle: const TextStyle(color: Colors.white, fontSize: 16),
                filled: true,
                fillColor: Color(0xFF3D3D3D),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: (value) {
                _sendMessage(value);
                _controller.clear();
              },
            ),
          ),
          IconButton(
            onPressed: () {
              _sendMessage(_controller.text);
              _controller.clear();
            },
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      messages.add({'message': Message(text: DialogText(text: [text])), 'isUserMessage': true});
    });

    DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(text: TextInput(text: text)));
    if (response.message == null) return;

    setState(() {
      messages.add({'message': response.message!, 'isUserMessage': false});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}

class MessagesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> messages;
  final ScrollController scrollController;

  const MessagesScreen({Key? key, required this.messages, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      controller: scrollController,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF3D3D3D),
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: Text(
                  messages[index]['message'].text.text[0],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => const Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: messages.length,
    );
  }
}
