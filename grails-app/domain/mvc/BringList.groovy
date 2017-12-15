package mvc

class BringList {
    String name
    String owner
    int listId
    int admin

    List<BringListItem> items = new ArrayList<>()

    static constraints = {
    }
}
