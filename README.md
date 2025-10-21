# QnA - Question & Answer Platform

A Stack Overflow-like Q&A platform built with Ruby on Rails where users can ask questions, provide answers, attach files, and mark the best answers.

## Features

- User authentication with Devise
- Ask and answer questions
- File attachments for questions and answers
- Mark best answer functionality
- Real-time updates with AJAX
- Responsive design with Slim templates

## Tech Stack

- **Ruby**: 2.7.2
- **Rails**: 5.2.3
- **Database**: PostgreSQL
- **Authentication**: Devise
- **File Uploads**: CarrierWave
- **Templates**: Slim
- **JavaScript**: CoffeeScript, jQuery
- **Testing**: RSpec, Capybara, Factory Bot

## System Dependencies

- Ruby 2.7.2
- PostgreSQL 9.5+
- Node.js (for asset compilation)
- Yarn

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd qna
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Setup database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the server:
```bash
rails server
```

5. Visit `http://localhost:3000`

## Configuration

### Database

Configure your database connection in `config/database.yml`

### File Uploads

Uploaded files are stored in `public/uploads/` directory by default. Configure CarrierWave settings in `app/uploaders/file_uploader.rb`

Supported file types:
- Images: jpg, jpeg, gif, png
- Documents: pdf, doc, docx, txt
- Archives: zip, rar

Maximum file size: 10MB

## Running Tests

Run the full test suite:
```bash
rspec
```

Run specific test files:
```bash
rspec spec/models/question_spec.rb
rspec spec/controllers/questions_controller_spec.rb
```

Run acceptance tests:
```bash
rspec spec/acceptance/
```

## Deployment

This application can be deployed to Heroku, AWS, or any other Rails-compatible hosting platform.

### Heroku Deployment

```bash
heroku create
git push heroku master
heroku run rails db:migrate
```

## Project Structure

```
app/
├── controllers/     # Application controllers
├── models/         # ActiveRecord models
├── views/          # Slim templates
├── uploaders/      # CarrierWave uploaders
├── assets/         # JavaScript, CSS, images
└── helpers/        # View helpers

spec/
├── models/         # Model specs
├── controllers/    # Controller specs
├── acceptance/     # Feature specs
└── factories/      # Factory Bot factories
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Security Considerations

- File uploads are validated for type and size
- CSRF protection is enabled
- User authentication required for creating/modifying content
- SQL injection protection via ActiveRecord

## License

This project is available as open source.
