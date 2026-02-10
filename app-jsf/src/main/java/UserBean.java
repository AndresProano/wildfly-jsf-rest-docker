import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;

import java.io.Serializable;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

@Named("userBean")
@RequestScoped
public class UserBean implements Serializable {
    private String message;

    public void restClient() {
        String baseUrl = System.getenv().getOrDefault(
                "REST_BASE_URL",
                "http://localhost:8080/app-rest/api"
        );
        String url = baseUrl.endsWith("/") ? baseUrl + "saludo" : baseUrl + "/saludo";

        try {
            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .GET()
                    .build();
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            this.message = response.body();
        } catch (Exception e) {
            this.message = "Error al conectar: " + e.getMessage();
        }
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
