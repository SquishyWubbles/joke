Scaffold(
        appBar: AppBar(
          title: Text('Flutter Intro'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 20,
                child: SizedBox(
                  width: 130,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: Colors.green,
                    ),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Height",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
