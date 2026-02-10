import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import jakarta.ws.rs.client.Client;
import jakarta.ws.rs.client.ClientBuilder;
import java.io.Serializable;

@Named
@RequestScoped
public class SaludoBean implements Serializable {
    private String mensajeDeRespuesta;

    public void llamarAlRest() {
        try {
            Client client = ClientBuilder.newClient();
            this.mensajeDeRespuesta = client.target("http://rest-service:8080/app-rest/api/saludo")
                    .request()
                    .get(String.class);
        } catch (Exception e) {
            this.mensajeDeRespuesta = "Error al conectar: " + e.getMessage();
        }
    }

    public String getMensajeDeRespuesta() { return mensajeDeRespuesta; }
    public void setMensajeDeRespuesta(String m) { this.mensajeDeRespuesta = m; }
}