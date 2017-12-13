package mvc

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
        bl.save(flush: true, failOnError: true)
        redirect (action:"list", params: [id: id])
    }

    def add(){
        String name = params.get('name')
        println "id " + params.get('list').class
        int id = Integer.parseInt(params.get('list'))
        BringList bl = BringList.all.get(id)
        BringListItem item = new BringListItem()
        item.name = name
        ArrayList<BringListItem> itemList= bl.items;
        itemList.add(item)
        bl.items = itemList
        bl.save(flush: true)
        redirect (action:"list", params: [id: id])
    }

    def admin(){

    }

    def list(){
        int id = Integer.parseInt(params.get('id'))
        render (view:"list", model: [bList: BringList.all.get(id)])
    }
}
