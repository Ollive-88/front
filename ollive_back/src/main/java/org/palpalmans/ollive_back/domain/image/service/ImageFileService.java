package org.palpalmans.ollive_back.domain.image.service;

import io.minio.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

import static io.minio.http.Method.GET;

@Service
@RequiredArgsConstructor
public class ImageFileService {

    private final MinioClient minioClient;

    @Value("${minio.bucket.name}")
    private String bucketName;

    public String saveImageFile(MultipartFile multipartFile) {
        try {
            return getUrl(save(multipartFile));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private String save(MultipartFile multipartFile) throws Exception {
        String fileName = UUID.randomUUID() + "-" + multipartFile.getOriginalFilename();
        validateBucket();

        minioClient.putObject(PutObjectArgs.builder()
                .bucket(bucketName)
                .object(fileName)
                .stream(multipartFile.getInputStream(), multipartFile.getSize(), -1)
                .contentType(multipartFile.getContentType())
                .build()
        );
        return fileName;
    }

    private void validateBucket() throws Exception {
        boolean isExist = minioClient.bucketExists(
                BucketExistsArgs.builder()
                        .bucket(bucketName)
                        .build()
        );
        if (!isExist) {
            minioClient.makeBucket(MakeBucketArgs.builder()
                    .bucket(bucketName)
                    .build()
            );
        }
    }

    private String getUrl(String fileName) throws Exception {
        return minioClient.getPresignedObjectUrl(
                GetPresignedObjectUrlArgs.builder()
                        .method(GET)
                        .bucket(bucketName)
                        .object(fileName)
                        .build());
    }
}
