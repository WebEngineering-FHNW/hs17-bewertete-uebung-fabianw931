package mvc

class BringList {
    String name
    String owner
    int listId
    int admintoken

    List<BringListItem> items = new ArrayList<>()

    static constraints = {
    }
}
