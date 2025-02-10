import ballerina/http;
import ballerina/log;

// Product types and interfaces
type Product record {
    string id;
    string name;
    string description;
    Pricing pricing;
};

type Pricing record {
    decimal baseRate;
    SpecialOffer[] specialOffers;
};

type SpecialOffer record {
    decimal rate;
    string validUntil;
};

// Service configuration
configurable string servicePath = "products";
configurable int servicePort = 8080;

// RESTful service
service / on new http:Listener(servicePort) {
    private final Product[] products = [
        {
            id: "savings-001",
            name: "Premium Savings Account",
            description: "High-yield savings account with premium benefits",
            pricing: {
                baseRate: 3.5,
                specialOffers: [
                    {rate: 4.0, validUntil: "2025-12-31"}
                ]
            }
        },
        {
            id: "checking-001",
            name: "Business Checking Plus",
            description: "Feature-rich checking account for businesses",
            pricing: {
                baseRate: 0.5,
                specialOffers: [
                    {rate: 1.0, validUntil: "2025-06-30"}
                ]
            }
        }
    ];

    // Get all products
    resource function get products() returns Product[]|error {
        log:printInfo("Fetching all products");
        return self.products;
    }

    // Get product by ID
    resource function get products/[string id]() returns Product|http:NotFound|error {
        log:printInfo(string `Fetching product with ID: ${id}`);
        
        Product? product = self.products.filter(p => p.id == id)[0];
        if product is () {
            return http:NOT_FOUND;
        }
        return product;
    }

    // Get product pricing
    resource function get products/[string id]/pricing() returns Pricing|http:NotFound|error {
        log:printInfo(string `Fetching pricing for product ID: ${id}`);
        
        Product? product = self.products.filter(p => p.id == id)[0];
        if product is () {
            return http:NOT_FOUND;
        }
        return product.pricing;
    }
}
