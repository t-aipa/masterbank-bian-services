import ballerina/http;
import ballerina/log;

// User Profile types and interfaces
type UserProfile record {
    string id;
    string name;
    string email;
    UserPreferences preferences;
    UserKYC kyc;
    string[] recommendations;
};

type UserPreferences record {
    string language;
    string theme;
    boolean notifications;
    NotificationSettings notificationSettings;
};

type NotificationSettings record {
    boolean email;
    boolean sms;
    boolean push;
    string[] categories;
};

type UserKYC record {
    string status;
    string verificationLevel;
    string lastVerified;
    Document[] documents;
};

type Document record {
    string type;
    string status;
    string uploadDate;
    string expiryDate;
};

// Service configuration
configurable string servicePath = "users";
configurable int servicePort = 8081;

// RESTful service
service / on new http:Listener(servicePort) {
    private final UserProfile[] users = [
        {
            id: "user-001",
            name: "John Smith",
            email: "john.smith@example.com",
            preferences: {
                language: "en",
                theme: "light",
                notifications: true,
                notificationSettings: {
                    email: true,
                    sms: true,
                    push: true,
                    categories: ["transactions", "security", "offers"]
                }
            },
            kyc: {
                status: "verified",
                verificationLevel: "full",
                lastVerified: "2025-01-15",
                documents: [
                    {
                        type: "passport",
                        status: "verified",
                        uploadDate: "2025-01-10",
                        expiryDate: "2030-01-10"
                    }
                ]
            },
            recommendations: [
                "Consider our Premium Savings Account",
                "Upgrade to Platinum Credit Card",
                "Investment portfolio diversification recommended"
            ]
        }
    ];

    // Get user profile
    resource function get users/[string userId]() returns UserProfile|http:NotFound|error {
        log:printInfo(string `Fetching user profile for ID: ${userId}`);
        
        UserProfile? user = self.users.filter(u => u.id == userId)[0];
        if user is () {
            return http:NOT_FOUND;
        }
        return user;
    }

    // Update user preferences
    resource function put users/[string userId]/preferences(@http:Payload UserPreferences payload) returns UserProfile|http:NotFound|error {
        log:printInfo(string `Updating preferences for user ID: ${userId}`);
        
        int? userIndex = self.users.indexOf(user => user.id == userId);
        if userIndex is () {
            return http:NOT_FOUND;
        }

        self.users[userIndex].preferences = payload;
        return self.users[userIndex];
    }

    // Get user recommendations
    resource function get users/[string userId]/recommendations() returns string[]|http:NotFound|error {
        log:printInfo(string `Fetching recommendations for user ID: ${userId}`);
        
        UserProfile? user = self.users.filter(u => u.id == userId)[0];
        if user is () {
            return http:NOT_FOUND;
        }
        return user.recommendations;
    }

    // Update KYC information
    resource function put users/[string userId]/kyc(@http:Payload UserKYC payload) returns UserProfile|http:NotFound|error {
        log:printInfo(string `Updating KYC for user ID: ${userId}`);
        
        int? userIndex = self.users.indexOf(user => user.id == userId);
        if userIndex is () {
            return http:NOT_FOUND;
        }

        self.users[userIndex].kyc = payload;
        return self.users[userIndex];
    }
}
