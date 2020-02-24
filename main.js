var newThietBi;
var newComp;
var specialCharacters = /[ !@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
console.log("Js đang chạy");
function checkLogin(id, password) {
    if(id === "a" && password === "a"){
        maFormLogin.visible = false;
        maMenuAdminTTB.visible = true;
    }
    else if (specialCharacters.test(id) || specialCharacters.test(password)){
        console.log("Tài khoản hoặc Mật khẩu không thể chứa ký tự đặc biệt");
    }
    else if (id === "" || password === ""){
        console.log("Tài khoản và mật khẩu không được để trống !");
    }
    else{
        maFormLogin.visible = false;
    }
}
function dialogCheck(){
    return dialogPressed;
}

function buttonClicked(){
    toggleDisplay = !toggleDisplay;
}
function createPoint(name){
    let newAddress = file.readFile(name + "Address").split(",");
    for(let i = 0; i < newAddress.length/2; i++){
        let j = i*2;
        let newComp = Qt.createComponent("ThemMoiThietBi.qml");
        let newObj = newComp.createObject(listPoint, {x: Number(newAddress[j]), y: Number(newAddress[j+1]) });
        newObj.clicked.connect(buttonClicked);
    }
}
function createRoomList(id, numberItems){
    let newAddress = file.readFile("temp").split(",");
    for(let j = 2; j < id.children.length; j++){
        id.children[j].destroy();
    }

    for(let i = 0; i < numberItems; i++){
        let comp = Qt.createComponent("ItemComponents.qml");
        let obj = comp.createObject(id, { roomName: newAddress[i*2].trim()});
        obj.clicked.connect(function (){choseRoom(i)});
    }
}
function clearAllItems(id, name){
    if(id.children.length > 2){
        for(let i = 2; i < id.children.length; i++){
            id.children[i].destroy();
        }
    }
    file.clearData(name);
}

function choseRoom(line){
    let newAddress = file.readFile("temp").split(",");
    let i = line*2;
    fileURLMain = newAddress[i+1];
    if(row.children.length > 2){
        for(let j = 2; j < row.children.length; j++){
            row.children[j].destroy();
        }
    }
    if(listPoint.children.length !== 0){
        for(let k = 1; k < listPoint.children.length; k++){
            listPoint.children[k].destroy();
        }
    }
//    insertItems(row,newAddress[i].trim());
    createPoint(newAddress[i].trim());
    currentRoom = newAddress[i].trim();
    createDeviceList();
}
function insertItems(id,name){
    var numberItems = file.numberLine(name + "Address");
    for(let i = 0; i < numberItems; i++){
        let comp = Qt.createComponent("ItemComponents.qml");
        let obj = comp.createObject(id);
    }
}

function insertImage(){
    fileURLMain = fileURL;
    inputRoomName.text = "";
    if(column.children.length > 2){
        for(let k = 2; k < column.children.length; k++){
            column.children[2].destroy();
        }
    }
    if(listPoint.children.length !== 0){
        for(let j = 1; j < listPoint.children.length; j++){
            listPoint.children[j].destroy();
        }
    }
    if(row.children.length > 2){
        for(let i = 2; i < row.children.length; i++){
            row.children[i].destroy();
        }
    }
    displayFormInput = true;
}
function createNewFile(name){
    if(!specialCharacters.test(name)){
        file.writeFile("temp", name + "," + fileURL + ",");
        displayFormInput = false;
    }
    else if(name === ""){
        console.log("Nhập tên phòng !");
    }
    else {
        console.log("Vui lòng không nhập ký tự đặc biệt !")
    }
}

// Create component when drag
function startDrag(mouse){
    menuAdminTP.opacity = 0;
    menuAdminTTB.opacity = 0;
    newComp = Qt.createComponent("ThemMoiThietBi.qml");
    newThietBi = newComp.createObject(listPoint);
    newThietBi.clicked.connect(buttonClicked);
    newThietBi.x = mouse.x - newThietBi.width/2;
    newThietBi.y = mouse.y - newThietBi.height/2;
}
function continueDrag(mouse){
    newThietBi.x = mouse.x;
    newThietBi.y = mouse.y;
}
function endDrag(name){
    menuAdminTP.opacity = 1;
    menuAdminTTB.opacity = 1;
    newThietBi.displayDeviceInput = true;
    file.writeFile(name + "Address", newThietBi.x + "," + newThietBi.y + ",");
//    let newComp = Qt.createComponent("ItemComponents.qml");
//    let newObj = newComp.createObject(row);
}
function createDevice(){
    if(!specialCharacters.test(currentDeviceName)){
        file.writeFile(currentRoom + "DeviceName", currentDeviceName + ",");
    }
    else if(currentDeviceName === ""){
        console.log("Nhập tên thiết bị !");
    }
    else {
        console.log("Vui lòng không nhập ký tự đặc biệt !")
    }

}

function createDeviceList(){
    let newAddress = file.readFile(currentRoom + "DeviceName").split(",");
    for(let j = 2; j < row.children.length ; j++){
        row.children[j].destroy();
    }
    for(let k = 0; k < newAddress.length - 1; k++){
        let newComp = Qt.createComponent("ItemComponents.qml");
        let newObj = newComp.createObject(row,{ roomName: newAddress[k].trim()});
    }
    console.log(newAddress);
}
