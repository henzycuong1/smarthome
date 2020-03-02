var newThietBi
var newComp
var specialCharacters = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/
console.log("Js's running")
function showLockScreen(){
    var x = set
}

function checkLogin(id, password) {
    if (id === "a" && password === "a") {
        maFormLogin.visible = false
        maMenuAdminTTB.visible = true
        maBackground.tSmartHomeVisiable = false
        admin = true
    } else if (specialCharacters.test(id) || specialCharacters.test(password)) {
        console.log("Tài khoản hoặc Mật khẩu không thể chứa ký tự đặc biệt hoặc dấu cách")
        messageBox.newTitle = "Lỗi đăng nhập"
        messageBox.newText = "Tài khoản hoặc Mật khẩu không thể chứa ký tự đặc biệt hoặc dấu cách"
        messageBox.visible = true
        admin = false
    } else if (id === "" || password === "") {
        console.log("Tài khoản và mật khẩu không được để trống !")
        messageBox.newTitle = "Lỗi đăng nhập"
        messageBox.newText = "Tài khoản hoặc mật khẩu không được để trống"
        messageBox.visible = true
        admin = false
    } else {
        maFormLogin.visible = false
        maMenuUsers.visible = true
        admin = false
        choseRoom(0)
    }
}
function pointClicked() {
    maDisplayMenuControl = !maDisplayMenuControl;

}
function createPoint(name, admin) {
    if (listPoint.children.length !== 0) {
        for (let k = 1; k < listPoint.children.length; k++) {
            listPoint.children[k].destroy()
        }
    }
    let newAddress = file.readFile(name + "Address").split(",")
    let getCode = file.readFile(name + "DeviceName").split(",")
    for (let i = 0; i < newAddress.length / 2 - 1; i++) {
        let j = i * 2
        let newComp = Qt.createComponent("ThemMoiThietBi.qml")
        let newObj = newComp.createObject(listPoint, {
                                              "x": Number(newAddress[j]),
                                              "y": Number(newAddress[j + 1]),
                                              "opacity": admin ? 1 : 1,
                                              "code": Number(getCode[j + 1]),
                                              "hoverItem": admin ? false : true
                                          })
        newObj.clicked.connect(function () { pointClicked()} )
    }
}
function createRoomList(id, number, admin) {
    let newAddress = file.readFile("temp").split(",")
    for (let j = 2; j < id.children.length; j++) {
        id.children[j].destroy()
    }
    for (let i = 0; i < number; i++) {
       let comp = Qt.createComponent("ItemComponents.qml")
       let obj = comp.createObject(id, {
                                       "roomName": newAddress[i * 2].trim(),
                                        "anchorsVarriable": false,
                                       "adminDel": admin ? true : false,
                                       "itemNumber": i,
                                       "idDel": "column",
                                       "nameFileDel": newAddress[i*2].trim()
                                   })
       obj.clicked.connect(function () {
           choseRoom(i,admin ? true : false)
       })
    }
}
function createRoomListUser(id, number, admin) {
    let newAddress = file.readFile("temp").split(",")
    for (let i = 0; i < number; i++) {
       let comp = Qt.createComponent("ItemUser.qml")
       let obj = comp.createObject(id, {
                                      "fileURL": newAddress[i*2+1]
                                   })
       obj.clicked.connect(function () {
           choseRoom(i,admin ? true : false)
       })
    }
}
function clearAllItems(id, name) {
    if (id.children.length > 2) {
        for (var i = 2; i < id.children.length; i++) {
            id.children[i].destroy()
        }
    }
    file.clearData(name)
}

function choseRoom(line,admin) {
    let newAddress = file.readFile("temp").split(",")
    let i = line * 2
    fileURLMain = newAddress[i + 1]
    createPoint(newAddress[i].trim(), admin ? true : false)
    console.log(admin)
    currentRoom = newAddress[i].trim()
    admin ? createDeviceList() : undefined
}

function insertImage() {
    fileURLMain = fileURL
    inputRoomName.text = ""
    if (column.children.length > 2) {
        for (let k = 2; k < column.children.length; k++) {
            column.children[2].destroy()
        }
    }
    if (listPoint.children.length !== 0) {
        for (let j = 1; j < listPoint.children.length; j++) {
            listPoint.children[j].destroy()
        }
    }
    if (row.children.length > 2) {
        for (let i = 2; i < row.children.length; i++) {
            row.children[i].destroy()
        }
    }
    let comp = Qt.createComponent("ItemComponent.qml")
    let obj = comp.createObject(column)
    displayFormInput = true
}
function createNewFile(name) {
    if (name === "") {
        console.log("Vui lòng không để trống tên phòng!")
        messageBox.newTitle = "Lỗi nhập tên"
        messageBox.newText = "Vui lòng không để trống tên phòng!"
        messageBox.visible = true
        return
    }
    if (!specialCharacters.test(name)) {
        file.writeFile("temp", name + "," + fileURL + ",")
        displayFormInput = false
    } else {
        console.log("Vui lòng không nhập ký tự đặc biệt hoặc dấu cách!")
        messageBox.newTitle = "Lỗi nhập tên"
        messageBox.newText = "Vui lòng không nhập ký tự đặc biệt hoặc dấu cách!"
        messageBox.visible = true
    }
}

// Create component when drag
function startDrag(mouse) {
    menuAdminTP.opacity = 0
    menuAdminTTB.opacity = 0
    newComp = Qt.createComponent("ThemMoiThietBi.qml")
    newThietBi = newComp.createObject(listPoint)
    newThietBi.x = mouse.x - newThietBi.width / 2
    newThietBi.y = mouse.y - newThietBi.height / 2
}
function continueDrag(mouse) {
    newThietBi.x = mouse.x - newThietBi.width / 2
    newThietBi.y = mouse.y - newThietBi.height / 2
}
function endDrag(name) {
    newThietBi.x > 500 ? newThietBi.rightInput = true : newThietBi.leftInput = true
    newThietBi.displayDeviceInput = true
    console.log(newThietBi.x + " " + newThietBi.rightInput + " " + newThietBi.leftInput)
    if (!specialCharacters.test(currentRoom)) {
        file.writeFile(name + "Address",
                       newThietBi.x + "," + newThietBi.y + ",")
    }
}
function createDevice(index) {
//    if (currentDeviceName === "") {
//        console.log("Vui lòng không để trống tên thiết bị!")
//        messageBox.newTitle = "Lỗi nhập tên"
//        messageBox.newText = "Vui lòng không để trống tên thiết bị!"
//        messageBox.visible = true
//        return
//    }
//    if (!specialCharacters.test(currentDeviceName)) {
        file.writeFile(currentRoom + "DeviceName", currentDeviceName + "," + index + ",")
        menuAdminTP.opacity = 1
        menuAdminTTB.opacity = 1
        displayDeviceInput = false
//    } else {
//        console.log("Vui lòng không để trống hoặc nhập ký tự đặc biệt !")
//        messageBox.newTitle = "Lỗi nhập tên"
//        messageBox.newText = "Vui lòng không để trống hoặc nhập ký tự đặc biệt !"
//        messageBox.visible = true
//        return
//    }
}

function createDeviceList() {
     let newAddress = file.readFile(currentRoom + "DeviceName").split(",")
        for (let j = 2; j < row.children.length; j++) {
            row.children[j].destroy()
        }
        console.log(newAddress)
        for (let k = 0; k < file.numberLine(currentRoom + "DeviceName"); k++) {
            let newComp = Qt.createComponent("ItemComponents.qml")
            let newObj = newComp.createObject(row, {
                                                  "roomName": newAddress[k*2],
                                                  "anchorsVarriable": true,
                                                  "adminDel": true,
                                                  "itemNumber": k,
                                                  "idDel": "row",
                                                  "nameFileDel": currentRoom
                                              })
        }
}
function deleteRoomOrDivice(id,number,name){
    if(id === "row"){
        file.deleteLine(name + "Address",number)
        file.deleteLine(name + "DeviceName", number)
        createPoint(name,true)
        createDeviceList()
    }
    if(id === "column"){
        file.deleteLine("temp",number)
        createRoomList(column,file.numberLine("temp"),true)
    }
}
function resets(){
    createPoint(currentRoom,true)
    createDeviceList()
    createRoomList(column,file.numberLine("temp"),true)
}
function dislayButton(codeNumber){
    console.log(codeNumber)
    if(codeNumber === 1 && admin === false){
        maButtonControl.displayBOnOff = true
        maButtonControl.displayBSpeed = true
        maButtonControl.displayBTemperature = false
        maButtonControl.displayBVolume = false
        maButtonControl.onOffTemperature = false
        return
    }
    if(codeNumber === 0 && admin === false) {
        maButtonControl.displayBOnOff = true
        maButtonControl.displayBSpeed = false
        maButtonControl.displayBTemperature = false
        maButtonControl.displayBVolume = false
        maButtonControl.onOffVolume = false
        maButtonControl.onOffTemperature = false
        return
    }
    if(codeNumber === 3 && admin === false){
        maButtonControl.displayBOnOff = true
        maButtonControl.displayBSpeed = false
        maButtonControl.displayBTemperature = true
        maButtonControl.displayBVolume = false
        maButtonControl.onOffVolume = false
        maButtonControl.onOffSpeed = false
        maButtonControl.onOffTemperature = false
        return
    }
    if(codeNumber === 2 && admin === false){
        maButtonControl.displayBOnOff = true
        maButtonControl.displayBSpeed = false
        maButtonControl.displayBTemperature = false
        maButtonControl.displayBVolume = true
        maButtonControl.onOffTemperature = false
        return
    }
}
