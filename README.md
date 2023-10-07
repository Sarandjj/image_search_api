# Animal Picture Search

## Folder Structure

Our project is structured as follows:

- `/lib`: Contains the Dart source code for the app.
- `/assets`: Stores any static assets, such as images.
- `/test`: Holds test files for unit and widget testing.
- `/android` and `/ios`: Platform-specific configurations and code.

## Usage

Once the app is running, you can use it to:

- Search for animal pictures by typing keywords in the search bar.
- Scroll through search results in a visually pleasing grid layout.
- Load more images as you reach the end of the current list.
- Enjoy beautiful animal images fetched from Unsplash's extensive collection.

## Contributing

We welcome contributions from the community. If you'd like to contribute, please follow these guidelines:

1. Fork this repository and create a branch for your contribution.
2. Make your changes, whether they are bug fixes, new features, or improvements.
3. Write unit and widget tests for your changes to ensure they work correctly.
4. Submit a pull request, providing a clear description of your changes.

## License

This project is licensed under the MIT License. For more details, see the LICENSE file.

## Dependencies

This project relies on the following external packages:

- `http`: Used for making HTTP requests to the Unsplash API.
- `provider`: Employed for state management.

## Configuration

To configure the app for your needs, you must provide an Unsplash API key. Create a `.env` file in the project root and add your API key as follows:

