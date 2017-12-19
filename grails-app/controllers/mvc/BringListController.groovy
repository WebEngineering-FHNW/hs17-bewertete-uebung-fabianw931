package mvc

import java.security.MessageDigest
import java.text.DateFormat
import java.text.SimpleDateFormat

class BringListController {

    /**
     * renders index view which includes a list of all BringLists
     *
     * @return index view
     */
    def index() {
        if(BringList.all.empty) render view: "index"
        render (view: "index", model: [bList: BringList.all])
    }

    /**
     *returns and redirects to a newly created empty BringList
     *
     * @return new BringList
     */
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

    /**
     * adds a BringListItem to an existing BringList
     *
     * @return BringList with new item
     */
    def add(){
        String name = params.get('name')
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

    /**
     * edits selected items from an existing BringList
     *
     * @return edited BringList
     */
    def editList(){
            int id = Integer.parseInt(params.get('list'))
            BringList bl = BringList.all.get(id)
            def items = request.getParameterValues('item')
            String bringer = params.get('bringer')


            ArrayList<BringListItem> itemArray= bl.items

            for(String stringId : items){
                int itemId = Integer.parseInt(stringId.replaceAll("\\D+",""))

                BringListItem item
                for(BringListItem bli : itemArray){
                    if (bli.itemId == itemId) item = bli
                }

                if(stringId.contains("true")){ // neu checked als true
                    item.checked = true
                    item.bringer = bringer

                }else{
                    item.checked = false
                    item.bringer = ""
                }
            }

            bl.items = itemArray
            bl.save(flush: true)
            if(params.get('admintoken')){
                redirect (action:"admin", params: [id: id], admintoken: params.get('admintoken'))
            }else{
                redirect (action:"list", params: [id: id])
            }
    }

    /**
     * used to redirect to different BringLists
     *
     * @return view to an existing BringList
     */
    def list(){
        int id = Integer.parseInt(params.get('id'))

        if(params.get('admintoken')){
            BringList a = BringList.all.get(id)
            int admintoken = a.admintoken
            render (view:"list", model: [admin: true, adminmode: true, token: admintoken, bList: a])
        }else{
            render (view:"list", model: [bList: BringList.all.get(id)])
        }
    }

    /**
     * checks if admintoken is correct and redirects to the corresponding admin site of the list
     *
     * @return access to the admin part of the list
     */
    def admin(){
        int id = Integer.parseInt(params.get('id'))
        BringList a = BringList.all.get(id)
        if (params.get('adminToken')){
            int admintoken = Integer.parseInt(params.get('adminToken'))

            if (admintoken == a.admintoken){
                render (view:"list", model: [admin: true, adminmode: true, bList: a])
            }else{
                render (view:"list", model: [bList: a])
            }
        }
        else{
            render (view:"list", model: [bList: a])
        }
    }

    /**
     * removes items from BringList
     *
     * @return edited BringList
     */
    def remove(){
        int listId = Integer.parseInt(params.get('listId'))
        int itemId = Integer.parseInt(params.get('itemId'))
        BringList bl = BringList.all.get(listId)

        ArrayList<BringListItem> itemArray= bl.items
        BringListItem item

        for (int i = 0; i < itemArray.size; i++) {
            if (itemArray.get(i).itemId == itemId){
                itemArray.remove(i)
            }
        }

        bl.items = itemArray
        bl.save(flush: true)
        redirect (action:"admin", params: [id: bl.id-1, adminToken: bl.admintoken])
    }
}
