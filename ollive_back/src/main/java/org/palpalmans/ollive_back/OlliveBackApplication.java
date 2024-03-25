package org.palpalmans.ollive_back;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@EnableJpaAuditing
@SpringBootApplication
@ConfigurationPropertiesScan
public class OlliveBackApplication {

    public static void main(String[] args) {
        SpringApplication.run(OlliveBackApplication.class, args);
    }

}
