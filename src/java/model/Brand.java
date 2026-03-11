package model;

public class Brand {

    private int id;
    private String name;
    private String logo;
    private String country;
    private boolean status;

    public Brand() {
    }

    public Brand(int id, String name, String logo, String country, boolean status) {
        this.id = id;
        this.name = name;
        this.logo = logo;
        this.country = country;
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

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }
}
