package model;

public class Category {

    private int id;
    private String name;
    private String slug;
    private String icon;
    private boolean status;

    public Category() {
    }

    public Category(int id, String name, String slug, String icon, boolean status) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.icon = icon;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
