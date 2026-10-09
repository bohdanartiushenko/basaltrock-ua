# basaltrock-ua

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Україномовна база знань з ШІ. Складіть свої документи в одну теку — і запитуйте їх звичайною мовою.

Усе працює на вашому компʼютері. Документи нікуди не надсилаються, інтернет потрібен лише для першого завантаження.

## Що потрібно

[Docker Desktop](https://www.docker.com/products/docker-desktop/) — встановити й запустити.
Gnu make, Linux / MacOS/ Windows + Linux tools.

## Як користуватися

Покладіть документи в теку `data`, потім у терміналі:

```bash
make up
```

Перший запуск триває кілька хвилин — завантажуються моделі та індексуються документи.

Коли побачите `Ready`, відкрийте **http://localhost** і запитуйте.

Щоб зупинити:

```bash
make down
```

Додали або змінили документи — `make ingest`.

## Які файли розуміє

`.txt`, `.md`, `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.csv`, `.html`


Якщо текст зі старих `.doc` виглядає як беліберда — спробуйте `make ingest DOC_ANSI_CODEPAGE=cp1252`.

## Ліцензія

MIT. Працює на основі [basaltrock](https://github.com/bohdanartiushenko/basaltrock).