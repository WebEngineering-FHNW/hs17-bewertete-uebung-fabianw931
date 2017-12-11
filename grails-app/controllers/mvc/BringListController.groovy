package mvc

class BringListController {


    def index() {
        println "printing bringLists"
        for(BringList bl : BringList.all){
            println bl.name
        }
        println "done printing"

        if(BringList.all.empty) render view: "index"
        render (view: "index", model: [bList: BringList.all])
    }

    def create(){
        String name = params.get('name');
        String owner = params.get('owner');
        BringList bl = new BringList();
        bl.name = name
        bl.owner = owner
        bl.save(flush: true, failOnError: true)
        render view: "list"
    }

    def add(){

    }

    def admin(){

    }
}
