# BC Usage Statistics

A Business Central extension for collecting and analyzing usage statistics of tables within the system. This extension allows administrators to track how often specific tables are accessed, providing insights into system usage patterns.

## Features

- **Usage Statistics Collection**: Tracks the number of times tables are accessed.
- **Configurable Frequency**: Allows scheduling statistics collection (Daily, Weekly, Monthly).
- **User Exclusion**: Option to exclude specific users from statistics collection.
- **API Integration**: Provides an API endpoint (`Usage Statistics API`) for external systems to fetch usage data.
- **Admin Dashboard**: Includes pages for configuration, setup, and viewing collected statistics.

## Setup

1. **Install the Extension**:
   - Download the `.app` file and install it in your Business Central environment.

2. **Configure Tables**:
   - Navigate to the `Usage Statistics Configuration` page to specify which tables to monitor.

3. **Enable Statistics Collection**:
   - Open the `Usage Statistics Setup` page and toggle the `Enabled` field to start collecting data.

4. **Schedule Frequency**:
   - Set the `Schedule Frequency` (Daily, Weekly, Monthly) to define how often statistics are generated.

5. **Exclude Users (Optional)**:
   - Use the `Skip Users` field to exclude specific users from statistics collection.

## Pages

- **Usage Statistics Setup**: Configure the extension settings.
- **Usage Statistics Configuration**: Manage which tables to monitor.
- **Usage Statistics List**: View collected statistics.
- **Usage Statistics API**: Access statistics via an API endpoint.
- **User Selection**: Select users to exclude from statistics.

## API Usage

The `Usage Statistics API` provides the following endpoints:
- **GET /v1.0/usage/usageStatistics**: Retrieve all usage statistics.
- **GET /v1.0/usage/usageStatistics({entryNo})**: Retrieve a specific statistic by `Entry No.`.

## Permissions

The `UsageStatistics` permission set grants access to all features of the extension. Assign this permission set to users who need to manage or view usage statistics.

## Contributing

Feel free to fork this project and submit pull requests for improvements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.