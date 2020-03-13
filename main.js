var objDrag
var compDrag
var tempX
var tempY
var specialCharacters = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/
function showMessage(title, content){
    messageBox.newTitle = title
    messageBox.newText = content
    messageBox.visible = true
    return
}
function checkLogin(id, password) {
    let dataAccount = JSON.parse(file.readFile("account.json"))
    let data = JSON.parse(file.readFile("data.json"))
    if (id === dataAccount[0].userName && password === dataAccount[0].userPassword) {
        mainFormLogin.visible = false
        mainMenuAdmin.visible = true
        mainBackground.isLoginScreen = false
//        mainRoom.visible = true
//        mainRoom.imageURL = "../icon/Background.png"
        trackingAdmin = true;
    } else if (specialCharacters.test(id) || specialCharacters.test(password)) {
        showMessage("Lỗi đăng nhập", "Tài khoản hoặc Mật khẩu không thể chứa ký tự đặc biệt hoặc dấu cách")
    } else if (id === "" || password === "") {
        showMessage("Lỗi đăng nhập", "Tài khoản hoặc mật khẩu không được để trống")
    } else if(data.length === 0){
        showMessage("Lỗi hệ thống","Vui lòng đăng nhập vào tài khoản admin thêm dữ liệu")
    } else {
        mainFormLogin.visible = false
        mainMenuUsers.visible = true
        trackingRoom = 0
        trackingAdmin = false
        choseRoom(0, false)
    }
}
function pointClicked() {
    mainDisplayMenuControl = !mainDisplayMenuControl;

}
function createPoint(name, isAdmin) {
    if (listPoint.children.length !== 0) {
        for (let k = 1; k < listPoint.children.length; k++) {
            listPoint.children[k].destroy()
        }
    }
    let jsonObj = JSON.parse(file.readFile("data.json"))
    let comp = Qt.createComponent("components/NewDevice.qml")
    if(comp.status !== Component.Ready){
        if(comp.status === Component.Error){
            showMessage("UI SYSTEM ERROR", "COMPONENT ERROR: " + comp.errorString())
            return
        }
    }
    for(let i = 0; i < jsonObj.length; i++){
        if(jsonObj[i].Room.name === name){
            for(let j = 0; j < jsonObj[i].Room.pointX.length;j++){
                let obj = comp.createObject(listPoint, {
                                                "x": Number(jsonObj[i].Room.pointX[j]),
                                                "y": Number(jsonObj[i].Room.pointY[j]),
                                                "opacity": isAdmin ? 1 : 1,
                                                "code": Number(jsonObj[i].Room.code[j]),
                                                "hoverItem": isAdmin ? false : true,
                                                "itemNumber": j
                                            })
                obj.clicked.connect(function(){ pointClicked() })
            }
        }
    }
}
function createRoomList(id, isAdmin) {
    for (let j = 2; j < id.children.length; j++) {
        id.children[j].destroy()
    }
    let jsonObj = JSON.parse(file.readFile("data.json"))
    let comp = Qt.createComponent("components/ItemComponents.qml")
    if(comp.status !== Component.Ready)
    {
       if(comp.status === Component.Error)
       {
           showMessage("UI SYSTEM ERROR","COMPONENT ERROR: " + comp.errorString() )
           return
       }
    }
    for(let i = 0; i < jsonObj.length; i++){
        let obj = comp.createObject(id,{
                                       "currentName": jsonObj[i].Room.name,
                                       "anchorsVarriable": false,
                                       "adminDel": isAdmin ? true : false,
                                       "itemNumber": i,
                                       "idDel": "column",
                                       "nameFileDel": jsonObj[i].Room.name,
                                       "fileURL": jsonObj[i].Room.imageURL
                                    })
       obj.clicked.connect(function () {
            trackingRoom = i
            choseRoom(i,isAdmin ? true : false)
            })
    }
}
function clearAllItems(id, name) {
    let jsonObj = JSON.parse(file.readFile("data.json"))
    if (id.children.length > 2) {
        for (let i = 2; i < id.children.length; i++) {
            id.children[i].destroy()
        }
    }
    if(id === column){
        jsonObj.splice(0,jsonObj.length)
    }
    if(id === row){
        for(let j = 0; j < jsonObj.length; j++){
            if(jsonObj[j].Room.name === name){
                jsonObj[j].Room.pointX.splice(0,jsonObj[j].Room.pointX.length)
                jsonObj[j].Room.pointY.splice(0,jsonObj[j].Room.pointY.length)
                jsonObj[j].Room.code.splice(0,jsonObj[j].Room.code.length)
                jsonObj[j].Room.nameDevice.splice(0,jsonObj[j].Room.nameDevice.length)
            }
        }
    }
    file.writeFile("data.json",JSON.stringify(jsonObj))
    resets()
}

function choseRoom(number,isAdmin) {
    let jsonObj = JSON.parse(file.readFile("data.json"))
    mainLockScreen.opacity = 0
    mainRoom.visible = true
    lockScreenTimer.running = true
    mainRoom.imageURL = jsonObj[number].Room.imageURL
    createPoint(jsonObj[number].Room.name, isAdmin ? true : false)
    isAdmin ? currentRoom = jsonObj[number].Room.name : undefined
    isAdmin ? createDeviceList() : undefined
}

function insertImage() {
    //Change image's showing
    mainRoom.imageURL = fileDialog.fileUrl
    inputRoomName.text = ""
    displayFormInput = true
}
function createNewRoom(name, imageURL) {
    if (name === "") {
        showMessage("Lỗi nhập tên", "Vui lòng không để trống tên phòng!")
        return
    }
    if (!specialCharacters.test(name)) {
        let oldData = JSON.parse(file.readFile("data.json"));
        let newRoom = {
            "Room":{
                "name": name,
                "pointX": [],
                "pointY": [],
                "code": [],
                "nameDevice": [],
                "imageURL": imageURL
            }
        }
        let newData = [];
        newData.push(newRoom);
        let newNewData = oldData.concat(newData);
        file.writeFile("data.json",JSON.stringify(newNewData));
        displayFormInput = false
        return
    } else {
        showMessage("Lỗi nhập tên", "Vui lòng không nhập ký tự đặc biệt hoặc dấu cách!")
        return
    }
}

// Create component when drag
function startDrag(mouse,itemNumber) {
    compDrag = Qt.createComponent("components/NewDevice.qml")
    if(compDrag.status !== Component.Ready)
    {
        if(compDrag.status === Component.Error){
            showMessage("UI SYSTEM ERROR", "COMPONENT ERROR: " + compDrag.errorString() )
            return
        }
    }
    objDrag = compDrag.createObject(listPoint)
    objDrag.x = mouse.x - objDrag.width / 2
    objDrag.y = mouse.y - objDrag.height / 2
}
function continueDrag(mouse) {
    objDrag.x = mouse.x - objDrag.width / 2
    objDrag.y = mouse.y - objDrag.height / 2
}
function endDrag(name) {
    let jsonObj = JSON.parse(file.readFile("data.json"))
    objDrag.x > 500 ? objDrag.rightInput = true : objDrag.leftInput = true
    objDrag.displayDeviceInput = true
    for(let i = 0; i < jsonObj.length; i++){
        if(jsonObj[i].Room.name === name){
            jsonObj[i].Room.pointX.push(objDrag.x)
            jsonObj[i].Room.pointY.push(objDrag.y)
        }
    }
    objDrag.itemNumber = listPoint.children.length - 2
    file.writeFile("data.json",JSON.stringify(jsonObj))

}
function createDevice(index) {
    containerMenuAdmin.pressed = false
//    file.writeFile(currentRoom + "DeviceName", currentDeviceName + "," + index + ",")
    let jsonObj = JSON.parse(file.readFile("data.json"))
    for(let i = 0; i < jsonObj.length; i++){
        if(jsonObj[i].Room.name === currentRoom){
            jsonObj[i].Room.code.push(index)
            jsonObj[i].Room.nameDevice.push(currentDeviceName)
        }
    }
    file.writeFile("data.json",JSON.stringify(jsonObj))
    displayDeviceInput = false
}

function createDeviceList() {
        for (let j = 2; j < row.children.length; j++) {
            row.children[j].destroy()
        }
        let jsonObj = JSON.parse(file.readFile("data.json"))
        let comp = Qt.createComponent("components/ItemComponents.qml")
        if(comp.status !== Component.Ready)
        {
           if(comp.status === Component.Error)
           {
               showMessage("UI SYSTEM ERROR","COMPONENT ERROR: " + comp.errorString() )
               return
           }
        }
        for(let i = 0; i < jsonObj.length; i++){
            if(jsonObj[i].Room.name === currentRoom){
                for(let j = 0; j < jsonObj[i].Room.nameDevice.length; j++){
                    let obj = comp.createObject(row,{
                                                      "currentName": jsonObj[i].Room.nameDevice[j],
                                                      "anchorsVarriable": true,
                                                      "adminDel": true,
                                                      "itemNumber": j,
                                                      "idDel": "row",
                                                      "nameFileDel": jsonObj[i].Room.name
                                                  })
                }
            }
        }
}
function deleteRoomOrDivice(id,number,name){
    let jsonObj = JSON.parse(file.readFile("data.json"))
    if(id === "row"){
        for(let i = 0; i< jsonObj.length; i++){
            if(jsonObj[i].Room.name === name){
                jsonObj[i].Room.pointX.splice(number-1,1)
                jsonObj[i].Room.pointY.splice(number-1,1)
                jsonObj[i].Room.code.splice(number-1,1)
                jsonObj[i].Room.nameDevice.splice(number-1,1)
            }
        }
    }
    if(id === "column"){
        jsonObj.splice(number,1)
    }
    file.writeFile("data.json",JSON.stringify(jsonObj))
    resets()
}
function resets(){
    createPoint(currentRoom,true)
    createDeviceList()
    createRoomList(column,true)
}
function changePassword(oldPassword, newPassword, checkNewPassword){
    let data = JSON.parse(file.readFile("account.json"))
    if(oldPassword !== data[0].userPassword){
        showMessage("Lỗi tài khoản", "Mật khẩu hiện tại không đúng")
        return
    }
    if(checkNewPassword !== newPassword){
        showMessage("Lỗi tài khoản", "Mật khẩu nhập lại không đúng")
        return
    }
    if(specialCharacters.test(newPassword)){
        showMessage("Lỗi tài khoản", "Mật khẩu không thể chứa ký tự đặc biệt hoặc dấu cách")
        return
    }
    data[0].userPassword = checkNewPassword
    file.writeFile("account.json",JSON.stringify(data))
}
function signOut(){
    mainRoom.visible = false
    mainFormLogin.visible = true
    mainMenuUsers.visible = false
    mainBackground.visible = true
    createPoint(undefined,false)
}
function checkItem(itemNumber){
    let data = JSON.parse(file.readFile("data.json"))
    for(let i = 0 ; i < data.length ; i++){
        if(data[i].Room.name === currentRoom){
            tempX = data[i].Room.pointX[itemNumber]
            tempY = data[i].Room.pointY[itemNumber]
        }
    }
}
function itemChangePosition(mouse,itemNumber){
    listPoint.children[itemNumber+1].x += (mouse.x - 50)
    listPoint.children[itemNumber+1].y += (mouse.y - 50)
}
function itemHasBeenChangePosition(itemNumber){
    let data = JSON.parse(file.readFile("data.json"))
    for(let i = 0 ; i < data.length ; i++){
        if(data[i].Room.name === currentRoom){
            data[i].Room.pointX[itemNumber] = listPoint.children[itemNumber+1].x
            data[i].Room.pointY[itemNumber] = listPoint.children[itemNumber+1].y
        }
    }
    file.writeFile("data.json",JSON.stringify(data))
}

