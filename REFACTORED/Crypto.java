package com.cyber.eshop.crypto;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Objects;

public class Crypto {

    private static final String HASH_ALGORITHM = "SHA-256";
    private static final int SALT_LENGTH = 16;

    public static String hash(String password, String salt) {
        Objects.requireNonNull(password, "Password must not be null");
        Objects.requireNonNull(salt, "Salt must not be null");

        try {
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] decodedSalt = Base64.getDecoder().decode(salt);
            md.update(decodedSalt);
            byte[] hashedBytes = md.digest(password.getBytes());
            return bytesToHex(hashedBytes);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("Hashing algorithm not found", e);
        }
    }

    public static String salt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[SALT_LENGTH];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    private static String bytesToHex(byte[] bytes) {
        StringBuilder sb = new StringBuilder();
        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }
}
