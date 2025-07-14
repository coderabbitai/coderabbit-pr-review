# PHPStan Integration

[PHPStan](https://phpstan.org) is a static analysis tool for PHP, designed to catch bugs and enforce code quality standards before runtime. This integration is intended for use with CodeRabbit to automate code review and ensure high-signal diagnostics on PHP projects.

---

## 📦 Version

`PHPSTAN_VERSION: 2.1.17`

---

## 📂 File Support

PHPStan will automatically analyze files with the `.php` extension.

---

## ⚙️ Configuration

CodeRabbit will not run PHPStan if no supported config file is found. The following config filenames are supported:

- `phpstan.neon`
- `phpstan.neon.dist`
- `phpstan.dist.neon`

> ℹ️ **Note**: CodeRabbit will not run PHPStan if no supported config file is found.

You can customize your rules and settings using the official configuration reference.

📄 [Configuration Reference →](https://phpstan.org/config-reference)

---

## 📚 Documentation

For more details on how PHPStan integrates with CodeRabbit, refer to the official guide:

🔗 [CodeRabbit PHPStan Docs →](https://docs.coderabbit.ai/tools/phpstan)
