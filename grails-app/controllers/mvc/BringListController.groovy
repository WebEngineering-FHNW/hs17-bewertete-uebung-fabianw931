package mvc

import java.security.MessageDigest
import java.text.DateFormat
import java.text.SimpleDateFormat

class BringListController {

    def index() {
        println BringList.count
        if(BringList.all.empty) render view: "index"
        render (view: "index", model: [bList: BringList.all])
    }

    def create(){
        String name = params.get('name')
        String owner = params.get('owner')
        int id = BringList.count
        BringList bl = new BringList();
        bl.name = name
        bl.owner = owner
        bl.listId = id

        DateFormat df = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Date today = Calendar.getInstance().getTime();
        String reportDate = df.format(today);
        MessageDigest m = MessageDigest.getInstance("MD5");
        m.update(reportDate.getBytes(),0,reportDate.length());
        int hash = reportDate.hashCode().abs()

        bl.admintoken = hash

        bl.save(flush: true, failOnError: true)
        redirect (action:"list", params: [id: id, admintoken: true, hash: hash])
    }

    def add(){
        String name = params.get('name')
        println "id " + params.get('list').class
        int id = Integer.parseInt(params.get('list'))
        BringList bl = BringList.all.get(id)
        BringListItem item = new BringListItem()
        ArrayList<BringListItem> itemList= bl.items;
        item.name = name
        item.itemId = itemList.size()
        itemList.add(item)
        bl.items = itemList
        bl.save(flush: true)
        redirect (action:"list", params: [id: id])
    }

    def admin(){
        int admintoken = Integer.parseInt(params.get('adminToken'))
        int id = Integer.parseInt(params.get('id'))
        BringList a = BringList.all.get(id)

        if (admintoken == a.admintoken){
            render (view:"list", model: [admin: true, adminmode: true, bList: a])
        }else{

        }
    }

    def editList(){
        int id = Integer.parseInt(params.get('list'))
        BringList bl = BringList.all.get(id)
        def items = request.getParameterValues('item')
        String bringer = params.get('bringer')


        ArrayList<BringListItem> itemArray= bl.items

        for(String stringId : items){
            int itemId = Integer.parseInt(stringId.replaceAll("\\D+",""))
            if(stringId.contains("true")){ // neu checked als true
                itemArray.get(itemId).checked = true
                itemArray.get(itemId).bringer = bringer

            }else{
                itemArray.get(itemId).checked = false
                itemArray.get(itemId).bringer = ""
            }
        }

        bl.items = itemArray
        bl.save(flush: true)
        if(params.get('admintoken')){
            redirect (action:"list", params: [id: id], admintoken: "true")
        }else{
            redirect (action:"list", params: [id: id])
        }
    }

    def list(){
        int id = Integer.parseInt(params.get('id'))

        if(params.get('admintoken')){
            BringList a = BringList.all.get(id)
            int admintoken = a.admintoken
            render (view:"list", model: [admin: true,adminmode: false, token: admintoken, bList: a])
        }else{
            render (view:"list", model: [bList: BringList.all.get(id)])
        }
    }

    def remove(){
        int id = Integer.parseInt(params.get('id'))
        BringList bl = BringList.all.get(id)
        def items = request.getParameterValues('item')

        ArrayList<BringListItem> itemArray= bl.items

        for(String stringId : items){
            int itemId = Integer.parseInt(stringId.replaceAll("\\D+",""))
            if(stringId.contains("false")){
                itemArray.remove(itemId)
            }
        }

        bl.items = itemArray
        bl.save(flush: true)
        redirect (action:"list", params: [id: id], admintoken: "true")
    }
}
