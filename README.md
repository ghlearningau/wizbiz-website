# wizbiz-website

A small static marketing site. Four pages, one stylesheet, one script,
no build step. Used as the running project for the GitHub course.

## Quick start

There is nothing to install. Open `index.html` in a browser, or serve the
folder so that relative paths and the console behave like production:

```powershell
# Any one of these works
python -m http.server 5173
npx --yes serve . --listen 5173
```

Then open http://localhost:5173

## Structure

```
wizbiz-website/
|-- index.html          Home
|-- about.html          About
|-- services.html       Services
|-- contact.html        Contact form
|-- css/style.css       All styling
|-- js/app.js           Year stamp, active nav, form validation
|-- tests/test-plan.md  Manual test cases and Definition of Done
|-- docs/deployment.md  How the site ships and how to roll back
|-- .gitignore
`-- README.md
```

## Contributing

Branch from `main`, commit in small steps, open a pull request, wait for
green checks. Branch names follow `type/short-description`, for example
`feat/pricing-page` or `fix/contact-form-validation`.

Commit messages follow Conventional Commits:

```
feat: add pricing page
fix: prevent duplicate contact form submits
docs: update deployment rollback steps
```

Before requesting review, work through `tests/test-plan.md`.

## Deployment

Merging to `main` publishes the site. See `docs/deployment.md`.

## License

MIT
