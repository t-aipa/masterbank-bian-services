import ballerina/http;

// Service configuration
configurable int servicePort = 8080;

// RESTful service
service / on new http:Listener(servicePort) {
    // Products Service
    resource function get products() returns json {
        return {
            "products": [
                {
                    "id": "prod-001",
                    "name": "Premium Savings Account",
                    "type": "SAVINGS",
                    "interestRate": 2.5
                }
            ]
        };
    }

    // Users Service
    resource function get users/[string userId]() returns json {
        return {
            "id": userId,
            "name": "John Smith",
            "email": "john.smith@example.com",
            "status": "active"
        };
    }

    // Transactions Service
    resource function get transactions/[string userId]() returns json {
        return {
            "transactions": [
                {
                    "id": "tx-001",
                    "userId": userId,
                    "amount": 100.00,
                    "type": "DEPOSIT",
                    "timestamp": "2025-02-10T08:55:37Z"
                }
            ]
        };
    }
}
