// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

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

        Rectangle {
            id: rectangle1
            x: 485
            y: 430
            width: 179
            height: 33
            radius: 8
            anchors.left: parent.left
            anchors.leftMargin: 485
            anchors.top: parent.top
            anchors.topMargin: 430
            gradient: Gradient {
                GradientStop {
                    position: 0.670
                    color: "#559933"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            border.width: 3
            border.color: "#00904d"
            clip: false
            smooth: true


            Text{
               id: buttonLabel
                 text: "Перезаписать БД"
                 anchors.centerIn: parent;
            }

            MouseArea {
                x: 0
                y: 0
                width: 179
                height: 33
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                onClicked: {
//                    title.text = "ok";
                    dbInit() ;
                }
            }
        }

        TextInput {
            id: title
            x: 316
            y: 78
            width: 211
            height: 24
            text: qsTr("")
            anchors.leftMargin: -217
            anchors.top: rectangle3.bottom
            anchors.topMargin: -28
            anchors.left: rectangle3.right
            transformOrigin: Item.Center
            z: 0
            rotation: 0
            selectedTextColor: "#600600"
            font.bold: false
            opacity: 1
            clip: false
            selectionColor: "#196f2e"
            smooth: false
            font.pixelSize: 16
        }

        //===========
        // Define a delegate component.  A component will be
        // instantiated for each visible item in the list.
        Component {
            id: petDelegate
            Item {
                id: wrapper
                width: 30; height: 80
                Column {
                    Text { text: 'Название: ' + title }
                    Text { text: 'Автор: ' + author }
                    Text { text: 'Издательство: ' + genre }
                    Text { text: 'Год: ' + year }
                    Text { text: 'Рейтинг: ' + rating }
                }
                // indent the item if it is the current item
                states: State {
                    name: "Current"
                    when: wrapper.ListView.isCurrentItem
                    PropertyChanges { target: wrapper; x: 20 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; duration: 300 }
                }
            }
        }

        // Define a highlight with customised movement between items.
        Component {
            id: highlightBar
            Rectangle {
                color: "lightsteelblue"; radius: 30
                width: 200; height: 70
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
                var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

                db.transaction(
                            function(tx) {

                                // Show all added greetings
                                var rs = tx.executeSql('SELECT * FROM books');
                                for(var i = 0; i < rs.rows.length; i++) {
                                    var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                                    listModel.append(data)

                                }
                                listModel.sync()
                            }
                            )
            }
        }

        Rectangle {
            id: rectangle3
            x: 308
            y: 73
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        Rectangle {
            id: rectangle4
            x: 539
            y: 73
            width: 125
            height: 33
            radius: 8
            gradient: Gradient {
                GradientStop {
                    position: 0.570
                    color: "#1ad3d0"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            clip: false
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 73
            Text {
                id: buttonLabel1
                text: "Найти"
                anchors.centerIn: parent
            }

            MouseArea {
                x: 0
                y: 0
                width: 125
                height: 33
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.left: parent.left
                onClicked: {
                  find() ;
                }
            }
            anchors.leftMargin: 539
            anchors.left: parent.left
        }

        TextInput {
            id: author
            x: 316
            y: 120
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 14
            font.pixelSize: 16
            transformOrigin: Item.Center
        }

        TextInput {
            id: genre
            x: 316
            y: 162
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 56
            font.pixelSize: 16
            transformOrigin: Item.Center
        }

        TextInput {
            id: year
            x: 316
            y: 205
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 99
            font.pixelSize: 16
            transformOrigin: Item.Center
        }

        TextInput {
            id: rating
            x: 316
            y: 247
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 141
            font.pixelSize: 16
            transformOrigin: Item.Center
        }

        Rectangle {
            id: rectangle5
            x: 308
            y: 116
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        Rectangle {
            id: rectangle6
            x: 308
            y: 242
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        Rectangle {
            id: rectangle7
            x: 308
            y: 201
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        Rectangle {
            id: rectangle8
            x: 308
            y: 158
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        Text {
            id: text1
            x: 240
            y: 121
            width: 56
            height: 23
            color: "#1a047a"
            text: qsTr("Author")
            font.bold: true
            font.family: "Monotype Corsiva"
            font.pixelSize: 20
        }

        Text {
            id: text2
            x: 240
            y: 79
            width: 56
            height: 23
            color: "#1a047a"
            text: qsTr("Title")
            font.pixelSize: 20
            font.family: "Monotype Corsiva"
            font.bold: true
        }

        Text {
            id: text3
            x: 240
            y: 163
            width: 56
            height: 23
            color: "#1a047a"
            text: qsTr("Genre")
            font.pixelSize: 20
            font.family: "Monotype Corsiva"
            font.bold: true
        }

        Text {
            id: text4
            x: 240
            y: 206
            width: 56
            height: 23
            color: "#1a047a"
            text: qsTr("Year")
            font.pixelSize: 20
            font.bold: true
            font.family: "Monotype Corsiva"
        }

        Text {
            id: text5
            x: 240
            y: 248
            width: 56
            height: 23
            color: "#1a047a"
            text: qsTr("Rating")
            font.pixelSize: 20
            font.bold: true
            font.family: "Monotype Corsiva"
        }

        Rectangle {
            id: rectangle9
            x: 539
            y: 116
            width: 125
            height: 33
            radius: 8
            clip: false
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 116
            Text {
                id: buttonLabel2
                text: "Обновить"
                anchors.centerIn: parent
            }

            MouseArea {
                x: 0
                y: 0
                width: 125
                height: 33
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.left: parent.left
                onClicked: {
                    reset() ;
                }
            }
            anchors.leftMargin: 539
            gradient: Gradient {
                GradientStop {
                    position: 0.570
                    color: "#1ad3d0"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            anchors.left: parent.left
        }

        Rectangle {
            id: rectangle10
            x: 539
            y: 158
            width: 125
            height: 33
            radius: 8
            clip: false
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 158
            Text {
                id: buttonLabel3
                text: "Добавить"
                anchors.centerIn: parent
            }

            MouseArea {
                x: 0
                y: 0
                width: 125
                height: 33
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.left: parent.left
                onClicked: {
                      add() ;
                  }
            }
            anchors.leftMargin: 539
            gradient: Gradient {
                GradientStop {
                    position: 0.570
                    color: "#1ad3d0"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            anchors.left: parent.left
        }

        Rectangle {
            id: rectangle11
            x: 539
            y: 201
            width: 125
            height: 33
            radius: 8
            clip: false
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 201
            Text {
                id: buttonLabel4
                text: "Удалить"
                anchors.centerIn: parent
            }

            MouseArea {
                x: 0
                y: 0
                width: 125
                height: 33
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.left: parent.left
                onClicked: {
                      del();
                  }


            }
            anchors.leftMargin: 539
            gradient: Gradient {
                GradientStop {
                    position: 0.570
                    color: "#1ad3d0"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            anchors.left: parent.left
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

        Rectangle {
            id: rectangle13
            x: 308
            y: 309
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        TextInput {
            id: all
            x: 316
            y: 314
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 208
            font.pixelSize: 16
            transformOrigin: Item.Center
        }

        Rectangle {
            id: rectangle14
            x: 308
            y: 351
            width: 225
            height: 33
            color: "#ffffff"
            opacity: 0.420
        }

        TextInput {
            id: smart
            x: 316
            y: 355
            width: 211
            height: 24
            text: qsTr("")
            anchors.top: rectangle3.bottom
            rotation: 0
            selectedTextColor: "#600600"
            selectionColor: "#196f2e"
            z: 0
            clip: false
            font.bold: false
            anchors.leftMargin: -217
            anchors.left: rectangle3.right
            opacity: 1
            smooth: false
            anchors.topMargin: 249
            font.pixelSize: 16
            transformOrigin: Item.Center
            onTextChanged: {
                findsmart();
            }

        }

        Text {
            id: text6
            x: 547
            y: 356
            width: 136
            height: 23
            color: "#ffffff"
            text: "Быстрый поиск"
            styleColor: "#601d1d"
            font.pixelSize: 15
            font.bold: false
            font.family: "Open Sans"
        }

        Rectangle {
            id: rectangle15
            x: 539
            y: 309
            width: 125
            height: 33
            radius: 8
            clip: false
            smooth: true
            anchors.top: parent.top
            anchors.topMargin: 309
            Text {
                id: buttonLabel5
                text: "Общий поиск"
                anchors.centerIn: parent
            }

            MouseArea {
                x: 0
                y: 0
                width: 125
                height: 33
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
                anchors.left: parent.left
                onClicked: {
                    findall();
                }
            }
            anchors.leftMargin: 539
            gradient: Gradient {
                GradientStop {
                    position: 0.570
                    color: "#1ad3d0"
                }

                GradientStop {
                    position: 1
                    color: "#000000"
                }
            }
            anchors.left: parent.left
        }



    function dbInit() {
        var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

        db.transaction(
                    function(tx) {
                        tx.executeSql('DROP TABLE books');
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

            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
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

            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )

        }

    function add() {
            listModel.clear();
            var result = "INSERT INTO books ('id', 'title', 'author', 'genre', 'year', 'rating') VALUES ('8','";

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

            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )
            reset();

        }

    function del() {
            listModel.clear();
            var result = "delete from books where id=8";


            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);
            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
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

            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
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

            var db = openDatabaseSync("QDeclarativeExampleDB", "1.0", "The Example QML SQL!", 1000000);

            db.transaction(
                        function(tx) {
            // Show all added greetings
            var rs = tx.executeSql(result);
            for(var i = 0; i < rs.rows.length; i++) {
                var data = {'title':rs.rows.item(i).title, 'author': rs.rows.item(i).author, 'genre': rs.rows.item(i).genre, 'year': rs.rows.item(i).year, 'rating': rs.rows.item(i).rating};
                listModel.append(data)

            }
            listModel.sync()
                        }
                        )
    }
}
