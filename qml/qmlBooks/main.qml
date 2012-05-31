// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "elements"
//import "fortext"

Rectangle {
    id: rectangle2
    width: 700
    height: 500
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#ffffff"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }
    }
    transformOrigin: Item.Center

    Text {
        id: txt
        x: 301
        y: 5
        width: 232
        height: 29
        color: "#e8cc12"
        text: "Библиотека книг"
        font.family: "Monotype Corsiva"
        styleColor: "#d9ff4f"
        font.bold: true
        font.italic: false
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 31
        anchors.verticalCenterOffset: -230
        anchors.horizontalCenterOffset: 67
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.NoWrap
        anchors.centerIn: parent
    }

//        TextInput {
//            id: title
//            x: 316
//            y: 78
//            width: 211
//            height: 24
//            text: qsTr("")
//            anchors.leftMargin: -217
//            anchors.top: rectangle3.bottom
//            anchors.topMargin: -28
//            anchors.left: rectangle3.right
//            transformOrigin: Item.Center
//            z: 0
//            rotation: 0
//            selectedTextColor: "#600600"
//            font.bold: false
//            opacity: 1
//            clip: false
//            selectionColor: "#196f2e"
//            smooth: false
//            font.pixelSize: 16
//        }
        Mtintput{
            id: title
            x: 316
            y: 78
            width: 211
            height: 24
        }

        //===========
        // Define a delegate component.  A component will be
        // instantiated for each visible item in the list.
        Component {
            id: petDelegate
            Item {
                id: wrapper
                width: 30; height: 100
                Column {
//                    Text { text: 'id: ' + id }
                    Text { text: 'Название: ' + title }
                    Text { text: 'Автор: ' + author }
                    Text { text: 'Издательство: ' + genre }
                    Text { text: 'Год: ' + year }
                    Text { text: 'Рейтинг: ' + rating }
                    Button{
                        id:delButtom
                        text:"Удалить"
                        type:"danger"
//                        anchors.right: parent.parent.right
                        visible: false
                        onClicked:  {
                            del(id)
                            //удалить из модели
                        }

                    }

                }

                // indent the item if it is the current item
                states: State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges { target: wrapper; x: 20 }
                    PropertyChanges { target: delButtom; visible: true }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; duration: 100 }
                }
            }
        }

        // Define a highlight with customised movement between items.
        Component {
            id: highlightBar
            Rectangle {
                color: "lightgray"; radius: 10
                width: 200; height: 85
                y: listView.currentItem.y;
                Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }
        }

        ListView {
            id: listView
            x: 12
            y: 37
            width: 200
            height:382

            model: ListModel {
                id: listModel
            }
            delegate: petDelegate
            focus: true

            // Set the highlight delegate. Note we must also set highlightFollowsCurrentItem
            // to false so the highlight delegate can control how the highlight is moved.
            highlight: highlightBar
            highlightFollowsCurrentItem: false

            Component.onCompleted: {
                var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);

                db.transaction(
                            function(tx) {

                                // Show all added greetings
                                var rs = tx.executeSql('SELECT * FROM books');
                                for(var i = 0; i < rs.rows.length; i++) {
                                    var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                                    listModel.append(data)

                                }
                                listModel.sync()
                            }
                            )
            }
        }

//        Rectangle {
//            id: author
//            x: 316
//            y: 120
//            width: 211
//            height: 24
//            color: "#ffffff"
//            opacity: 0.420
//        }
        Mtintput{
            id: author
            x: 316
            y: 120
            width: 211
            height: 24
        }

//        TextInput {
//            id: author
//            x: 316
//            y: 120
//            width: 211
//            height: 24
//            text: qsTr("")
//            anchors.top: rectangle3.bottom
//            rotation: 0
//            selectedTextColor: "#600600"
//            selectionColor: "#196f2e"
//            z: 0
//            clip: false
//            font.bold: false
//            anchors.leftMargin: -217
//            anchors.left: rectangle3.right
//            opacity: 1
//            smooth: false
//            anchors.topMargin: 14
//            font.pixelSize: 16
//            transformOrigin: Item.Center
//        }
        Mtintput{
            id: genre
            x: 316
            y: 162
            width: 211
            height: 24
        }

//        TextInput {
//            id: genre
//            x: 316
//            y: 162
//            width: 211
//            height: 24
//            text: qsTr("")
//            anchors.top: rectangle3.bottom
//            rotation: 0
//            selectedTextColor: "#600600"
//            selectionColor: "#196f2e"
//            z: 0
//            clip: false
//            font.bold: false
//            anchors.leftMargin: -217
//            anchors.left: rectangle3.right
//            opacity: 1
//            smooth: false
//            anchors.topMargin: 56
//            font.pixelSize: 16
//            transformOrigin: Item.Center
//        }
        Mtintput{
            id: year
            x: 316
            y: 205
            width: 211
            height: 24
        }

//        TextInput {
//            id: year
//            x: 316
//            y: 205
//            width: 211
//            height: 24
//            text: qsTr("")
//            anchors.top: rectangle3.bottom
//            rotation: 0
//            selectedTextColor: "#600600"
//            selectionColor: "#196f2e"
//            z: 0
//            clip: false
//            font.bold: false
//            anchors.leftMargin: -217
//            anchors.left: rectangle3.right
//            opacity: 1
//            smooth: false
//            anchors.topMargin: 99
//            font.pixelSize: 16
//            transformOrigin: Item.Center
//        }
        Mtintput{
            id: rating
            x: 316
            y: 247
            width: 211
            height: 24
        }

//        TextInput {
//            id: rating
//            x: 316
//            y: 247
//            width: 211
//            height: 24
//            text: qsTr("")
//            anchors.top: rectangle3.bottom
//            rotation: 0
//            selectedTextColor: "#600600"
//            selectionColor: "#196f2e"
//            z: 0
//            clip: false
//            font.bold: false
//            anchors.leftMargin: -217
//            anchors.left: rectangle3.right
//            opacity: 1
//            smooth: false
//            anchors.topMargin: 141
//            font.pixelSize: 16
//            transformOrigin: Item.Center
//        }

//        Rectangle {
//            id: rectangle5
//            x: 308
//            y: 116
//            width: 225
//            height: 33
//            color: "#ffffff"
//            opacity: 0.420
//        }

//        Rectangle {
//            id: rectangle6
//            x: 308
//            y: 242
//            width: 225
//            height: 33
//            color: "#ffffff"
//            opacity: 0.420
//        }

//        Rectangle {
//            id: rectangle7
//            x: 308
//            y: 201
//            width: 225
//            height: 33
//            color: "#ffffff"
//            opacity: 0.420
//        }

//        Rectangle {
//            id: rectangle8
//            x: 308
//            y: 158
//            width: 225
//            height: 33
//            color: "#ffffff"
//            opacity: 0.420
//        }

        Mtext{
            id: text1
            y: 121
            text: qsTr("Author")
        }
        Mtext{
            id: text2
            y: 79
           text: qsTr("Title")
        }
        Mtext{
            id: text3
            y: 163
           text: qsTr("Genre")
        }
        Mtext{
            id: text4
            y: 206
           text: qsTr("Year")
        }
        Mtext{
            id: text5
            y: 248
           text: qsTr("Rating")
        }



        Button{
            id:findButton
            x: 539
            y: 73
            width: 125
            height: 29
//            anchors.top: parent.top
//            anchors.topMargin: 73
            buttonsize: "large"
            text: "Найти"
            onClicked: find();
        }

        Button{
            id:resetButton
            x: 539
            y: 118
            width: 125
            height: 29
//            anchors.top: parent.top
//            anchors.topMargin: 118
            buttonsize: "large"
            text: "Обновить"
            onClicked: reset();
        }

        Button{
            id:addButton
            x: 539
            y: 160
            width: 125
            height: 29
//            anchors.top: parent.top
//            anchors.topMargin: 160
            buttonsize: "large"
            text: "Добавить"
            onClicked: add();
        }
        Button{
            id:findallButton
            x: 539
            y: 323
            width: 125
            height: 29
//            anchors.top: parent.top
//            anchors.topMargin: 323
            buttonsize: "large"
            text: "Общий поиск"
            onClicked: findall();
        }
        Button{
            id:initButton
            x: 542
            y: 416
            width: 125
            height: 29
//            anchors.top: parent.top
//            anchors.topMargin: 416
            buttonsize: "large"
            text: "Перезаписать"
            onClicked: dbInit();
        }

        Rectangle {
            id: rectangle12
            x: 224
            y: 37
            width: 3
            height: 382
            radius: 0
            border.color: "#2e7980"
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#35606f"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
        }


        Mtintput{
            x: 308
            y: 321
            width: 225
            height: 33
        }
        Mtintput{
            id: smart
            x: 316
            y: 367
            width: 211
            height: 24
            onTextChanged: findsmart();
        }

        Text {
            id: text6
            x: 547
            y: 368
            width: 136
            height: 23
            color: "#ffffff"
            text: "Быстрый поиск"
            styleColor: "#601d1d"
            font.pixelSize: 15
            font.bold: false
            font.family: "Open Sans"
        }




    function dbInit() {
        var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);

        db.transaction(
                    function(tx) {
                        tx.executeSql('DROP TABLE books');
                    }
                    )
            db.transaction(
                        function(tx) {
                            // Create the database if it doesn't already exist
                            tx.executeSql('CREATE TABLE books (id INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,'+
                                          'title VARCHAR(255)  NULL,'+
                                          'author VARCHAR(255)  NULL,'+
                                          'genre VARCHAR(255)  NULL,'+
                                          'year VARCHAR(255)  NULL,'+
                                          'rating VARCHAR(255)  NULL'+
                                          ');');

                            // Add (another) greeting row
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('1', 'C#', 'Shildt', 'Programing', '2004', '4');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('2', 'C# and ASP', 'O Rielly', 'Programing', '2006', '2');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('3', 'Kolobok', 'Unknown', 'Tales', '1991', '5');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('4', 'War and Peace', 'Tolstoy', 'Novel', '1879', '5');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('5', 'Kursvoe proektirovanie', 'Dunaev', 'Learning', '1979', '1');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('6', '1000 Records', 'Unknown', 'Various', '2000', '3');");
                            tx.executeSql("insert into books ('id', 'title', 'author', 'genre', 'year', 'rating') values ('7', 'C++', 'Shildt', 'Programing', '2000', '2');");
                        }
                        )
            reset();
    }

    function find() {
            listModel.clear();
            var au = false, ti=false, ge=false, ra=false, ye=false, first=true;
            var result = "SELECT * FROM books WHERE ";

            if ( author.text !="") au = true;
            if ( title.text !="") ti = true;
            if ( genre.text !="") ge = true;
            if ( year.text !="") ye = true;
            if ( rating.text !="") ra = true;

            if (au == true)
            {
                if (!first)
                {
                    result+=" AND ";
                }
                result+="author LIKE '%";
                result+=author.text;
                result+="%'";
                first=false;
            }
            if (title)
            {
                if (!first)
                {
                    result+=" AND ";
                }
                result+="title LIKE '%";
                result+=title.text;
                result+="%'";
                first=false;
            }
            if (genre)
            {
                if (!first)
                {
                    result+=" AND ";
                }
                result+="genre LIKE '%";
                result+=genre.text;
                result+="%'";
                first=false;
            }
            if (year)
            {
                if (!first)
                {
                    result+=" AND ";
                }
                result+="year LIKE '%";
                result+=year.text;
                result+="%'";
                first=false;
            }
            if (rating)
            {
                if (!first)
                {
                    result+=" AND ";
                }
                result+="rating LIKE '%";
                result+=rating.text;
                result+="%'";
                first=false;
            }

            var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )
        }

    function reset() {
            listModel.clear();
            var result = "SELECT * FROM books";
            author.text ="";
            title.text ="";
            genre.text ="";
            year.text ="";
            rating.text ="";
            all.text ="";
            smart.text ="";

            var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )

        }

    function add() {
        listModel.clear();
        var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);
            var n;

            db.transaction(
            function(tx) {
                            var rsmax = tx.executeSql("SELECT id FROM books");
                            n = rsmax.rows.length+1;
                            console.log(rsmax.rows.length);
            }
            )


        var result = "INSERT INTO books ('id', 'title', 'author', 'genre', 'year', 'rating') VALUES ('";
        result+=n;
        result+="','";
        result+=title.text;
        result+="', '";
        result+=author.text;
        result+="', '";
        result+=genre.text;
        result+="', '";
        result+=year.text;
        result+="', '";
        result+=rating.text;
        result+="')";

            db.transaction(
            function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }

            listModel.sync()
                        }
                        )

            reset();
            smart.text = data;

        }

    function del(id) {
            listModel.clear();
            var result = "delete from books where id=";
            result+=id;


            var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                        function(tx) {
            // Show all added greetings
            /*var rs = */tx.executeSql(result);
//            for(var i = 0; i < rs.rows.length; i++) {
//                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
//                listModel.append(data)

//            }
//            listModel.sync()
                        }
                        )
            reset();

        }

    function findall() {
            listModel.clear();
            var result="SELECT * FROM books WHERE ";
                            result+="title LIKE '%";
                           result+=all.text;
                           result+="%' OR author LIKE '%";
                           result+=all.text;
                           result+="%' OR genre LIKE '%";
                           result+=all.text;
                           result+="%' OR year LIKE '%";
                           result+=all.text;
                           result+="%' OR rating LIKE '%";
                           result+=all.text;
                           result+="%'";

            var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )
    }

    function findsmart() {
            listModel.clear();
            var result="SELECT * FROM books WHERE ";
                            result+="title LIKE '%";
                           result+=smart.text;
                           result+="%' OR author LIKE '%";
                           result+=smart.text;
                           result+="%' OR genre LIKE '%";
                           result+=smart.text;
                           result+="%' OR year LIKE '%";
                           result+=smart.text;
                           result+="%' OR rating LIKE '%";
                           result+=smart.text;
                           result+="%'";

            var db = openDatabaseSync("QDeclarativeExampleDB11", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'id':rs.rows.item(i).id,'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )
    }
}
