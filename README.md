# Masterbank BIAN Services

This repository contains BIAN-compliant banking services implemented using Ballerina for deployment on Choreo.

## Services

### 1. Products Service
- Get all products
- Get product by ID
- Get product pricing
- Special offers

### 2. User Profile Service (Coming Soon)
- User profile management
- Preferences
- Recommendations

### 3. Transaction Service (Coming Soon)
- Transaction history
- Transaction processing
- Account balances

## Development

### Prerequisites
1. Ballerina Swan Lake
2. Choreo CLI
3. Git

### Setup
```bash
# Clone the repository
git clone https://github.com/your-org/masterbank-bian-services.git

# Navigate to project directory
cd masterbank-bian-services

# Build the project
bal build

# Run locally
bal run
```

### Deployment
This project is configured for automatic deployment on Choreo. Each service will be deployed as a separate component.

## API Documentation
API documentation is automatically generated and available in the Choreo Developer Portal.

## Monitoring
- API Analytics
- Distributed Tracing
- Log Analysis
- Performance Metrics

## Security
- OAuth2 authentication
- Role-based access control
- API key management
- Rate limiting
