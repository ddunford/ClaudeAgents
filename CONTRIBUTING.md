# Contributing to Munero

We love your input! We want to make contributing to Munero as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## We Develop with Github

We use GitHub to host code, to track issues and feature requests, as well as accept pull requests.

## We Use [Github Flow](https://guides.github.com/introduction/flow/index.html)

Pull requests are the best way to propose changes to the codebase. We actively welcome your pull requests:

1. Fork the repo and create your branch from `main`.
2. If you've added code that should be tested, add tests.
3. If you've changed APIs, update the documentation.
4. Ensure the test suite passes.
5. Make sure your code lints.
6. Issue that pull request!

## Any contributions you make will be under the MIT Software License

In short, when you submit code changes, your submissions are understood to be under the same [MIT License](http://choosealicense.com/licenses/mit/) that covers the project. Feel free to contact the maintainers if that's a concern.

## Report bugs using Github's [issue tracker](https://github.com/yourusername/munero/issues)

We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/yourusername/munero/issues/new); it's that easy!

## Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can.
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## Development Process

1. Clone the repository
2. Install dependencies: `npm install`
3. Create a new branch: `git checkout -b feature/your-feature`
4. Make your changes
5. Run tests: `npm test`
6. Run linting: `npm run lint`
7. Commit your changes: `git commit -m 'Add some feature'`
8. Push to the branch: `git push origin feature/your-feature`
9. Submit a pull request

### Development Environment Setup

```bash
# Install dependencies
npm install

# Run tests
npm test

# Run linting
npm run lint

# Build
npm run build

# Generate documentation
npm run docs
```

### Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification. This leads to more readable messages that are easy to follow when looking through the project history.

Examples:

```
feat: add hat wobble
^--^  ^------------^
|     |
|     +-> Summary in present tense.
|
+-------> Type: feat, fix, docs, style, refactor, test, or chore.
```

Common types:
- feat: (new feature)
- fix: (bug fix)
- docs: (changes to documentation)
- style: (formatting, missing semi colons, etc; no code change)
- refactor: (refactoring production code)
- test: (adding missing tests, refactoring tests)
- chore: (updating grunt tasks etc; no production code change)

### Code Style

- We use TypeScript
- We use Prettier for code formatting
- We use ESLint for linting
- We follow the [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html)

### Testing

- Write tests for all new features
- Maintain test coverage above 90%
- Run the test suite before submitting a PR
- Include both unit and integration tests where appropriate

### Documentation

- Update documentation for any changed functionality
- Add JSDoc comments for all public APIs
- Keep README.md updated with any new features or changes
- Generate API documentation using TypeDoc

## License

By contributing, you agree that your contributions will be licensed under its MIT License. 