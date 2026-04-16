# Portfolio Page Setup

This project uses a **public/private repository separation** structure:

## Repository Structure

| Repository | Visibility | Content |
|------------|------------|---------|
| [`portfolio-page`](https://github.com/Dr-Mira/portfolio-page) | **Public** | Main website code, HTML/CSS/JS, public assets |
| [`portfolio-page-assets`](https://github.com/Dr-Mira/portfolio-page-assets) | **Private** | Sensitive files: resume PDFs, personal images, private videos, internal code |

## How It Works

The `assets/` folder is a **git submodule** linked to the private `portfolio-page-assets` repository.

- When someone clones the public repo, the `assets/` folder appears empty or unpopulated
- Only users with access to the private repo can fetch the actual assets
- The public repo maintains a reference to the specific commit of the private assets

## Initial Setup

### 1. Clone the public repository

```bash
git clone https://github.com/Dr-Mira/portfolio-page.git
cd portfolio-page
```

### 2. Initialize and update the submodule (requires private repo access)

```bash
git submodule update --init --recursive
```

Or clone with submodules:

```bash
git clone --recurse-submodules https://github.com/Dr-Mira/portfolio-page.git
```

## Daily Workflow

### Making changes to public code

```bash
# Edit files in the main directory (NOT in assets/)
git add .
git commit -m "Your commit message"
git push origin main
```

### Making changes to private assets

```bash
# Navigate to the assets folder
cd assets/

# Make your changes, then commit to the PRIVATE repo
git add .
git commit -m "Update resume PDF"
git push origin main

# Go back to main project and update the submodule reference
cd ..
git add assets
git commit -m "Update assets submodule to latest"
git push origin main
```

### Pulling latest changes

```bash
# Pull public changes
git pull origin main

# Update assets submodule to the referenced commit
git submodule update

# Or update to the latest assets (requires private access)
cd assets/
git pull origin main
```

## Important Notes

- **Security**: While this makes it harder to clone private assets, note that any deployed website will still expose these assets to visitors. This setup primarily protects against direct repository cloning.
- **Submodule references**: When you update the assets repo, remember to also commit the submodule reference change in the main repo.
- **Private access**: Anyone without access to `portfolio-page-assets` will see an empty `assets/` folder after cloning.

## Troubleshooting

### Empty assets folder after clone

You need access to the private repository. If you have access:

```bash
git submodule update --init --recursive
```

### Submodule not updating

```bash
# Force update to latest
cd assets/
git checkout main
git pull origin main
cd ..
git add assets
git commit -m "Update assets submodule"
```

### Detached HEAD in submodule

```bash
cd assets/
git checkout main
```
