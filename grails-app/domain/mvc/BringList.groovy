package mvc

class BringList {
    String name
    String owner
    int listId

    List<BringListItem> items = new ArrayList<>()

    static constraints = {
    }
}
