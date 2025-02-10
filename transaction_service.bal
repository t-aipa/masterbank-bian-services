import ballerina/http;
import ballerina/log;
import ballerina/time;

// Transaction types and interfaces
type Transaction record {
    string id;
    string userId;
    string accountId;
    TransactionType type;
    decimal amount;
    string currency;
    string status;
    time:Civil timestamp;
    string description;
    TransactionMetadata metadata;
};

enum TransactionType {
    DEPOSIT,
    WITHDRAWAL,
    TRANSFER,
    PAYMENT,
    FEE
}

type TransactionMetadata record {
    string category;
    string merchantName?;
    string merchantId?;
    Location location?;
    string reference?;
};

type Location record {
    string country;
    string city?;
    string address?;
    float latitude?;
    float longitude?;
};

type Balance record {
    string accountId;
    decimal available;
    decimal current;
    string currency;
    time:Civil lastUpdated;
};

// Service configuration
configurable string servicePath = "transactions";
configurable int servicePort = 8082;

// RESTful service
service / on new http:Listener(servicePort) {
    private final Transaction[] transactions = [
        {
            id: "tx-001",
            userId: "user-001",
            accountId: "acc-001",
            type: PAYMENT,
            amount: 99.99,
            currency: "USD",
            status: "completed",
            timestamp: {
                year: 2025,
                month: 2,
                day: 10,
                hour: 10,
                minute: 30,
                second: 0
            },
            description: "Online Purchase - Amazon",
            metadata: {
                category: "shopping",
                merchantName: "Amazon",
                merchantId: "AMZN-001",
                location: {
                    country: "USA",
                    city: "Seattle"
                },
                reference: "ORD-12345"
            }
        }
    ];

    private final Balance[] balances = [
        {
            accountId: "acc-001",
            available: 5000.00,
            current: 4900.01,
            currency: "USD",
            lastUpdated: {
                year: 2025,
                month: 2,
                day: 10,
                hour: 10,
                minute: 30,
                second: 0
            }
        }
    ];

    // Get transactions for user
    resource function get users/[string userId]/transactions() returns Transaction[]|error {
        log:printInfo(string `Fetching transactions for user ID: ${userId}`);
        return self.transactions.filter(tx => tx.userId == userId);
    }

    // Get transaction by ID
    resource function get transactions/[string transactionId]() returns Transaction|http:NotFound|error {
        log:printInfo(string `Fetching transaction ID: ${transactionId}`);
        
        Transaction? transaction = self.transactions.filter(tx => tx.id == transactionId)[0];
        if transaction is () {
            return http:NOT_FOUND;
        }
        return transaction;
    }

    // Get account balance
    resource function get accounts/[string accountId]/balance() returns Balance|http:NotFound|error {
        log:printInfo(string `Fetching balance for account ID: ${accountId}`);
        
        Balance? balance = self.balances.filter(b => b.accountId == accountId)[0];
        if balance is () {
            return http:NOT_FOUND;
        }
        return balance;
    }

    // Create new transaction
    resource function post transactions(@http:Payload Transaction payload) returns Transaction|error {
        log:printInfo(string `Creating new transaction for user ID: ${payload.userId}`);
        
        // In real implementation, we would:
        // 1. Validate transaction
        // 2. Check account balance
        // 3. Process payment/transfer
        // 4. Update balances
        // 5. Send notifications
        
        self.transactions.push(payload);
        return payload;
    }
}
