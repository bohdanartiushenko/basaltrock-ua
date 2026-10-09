# basaltrock-ua

Україномовна локальна база знань (з ШІ) на основі [basaltrock](https://github.com/bohdanartiushenko/basaltrock).

Повністю працює локально: документи не покидають вашу машину. Потрібні лише Docker та `make`.

## Використання

```bash
make up     DATA_FOLDER=/шлях/до/документів
make down
```

`make up` завантажує останній реліз basaltrock з GitHub у `.basaltrock/<версія>/`, запускає індексацію документів і піднімає API.

Після запуску:

- Веб-інтерфейс: http://localhost:80
- API: http://localhost:80/retrieveAndGenerate
- OpenSearch: http://localhost:9200

## Команди

| Команда | Опис |
|---|---|
| `make up` | Завантажити basaltrock і запустити базу знань на :80 |
| `make fetch` | Лише завантажити basaltrock |
| `make down` | Зупинити |
| `make restart` | Перезапустити |
| `make ingest` | Переіндексувати документи |
| `make rtf2txt` | Конвертувати `.rtf` у `.txt` (macOS, `textutil`) |
| `make tune-models` | Застосувати налаштування моделі (keep-alive, розмір контексту) |
| `make logs` | Дивитися логи |
| `make status` | Показати контейнери |
| `make prune` | Видалити томи |

## Формати документів

`.txt`, `.md`, `.html`, `.htm`, `.pdf`, `.doc`, `.docx`, `.xls`, `.xlsx`, `.csv`.

Файли `.rtf` спершу конвертуйте через `make rtf2txt`.

Для старих `.doc` з однобайтовим кодуванням використовується кодова сторінка `DOC_ANSI_CODEPAGE` (типово `cp1251`).

## Змінні

| Змінна | Типове значення |
|---|---|
| `BASALTROCK_GH` | `bohdanartiushenko/basaltrock` |
| `BASALTROCK_VERSION` | останній тег релізу з GitHub |
| `BASALTROCK` | `.basaltrock/$(BASALTROCK_VERSION)` |
| `DATA_FOLDER` | `data` |
| `DOC_ANSI_CODEPAGE` | `cp1251` |
| `MODEL_RUNNER_LLM_CHAT` | `ai/gemma4:e2b-safetensors` |
| `MODEL_RUNNER_LLM_EMBEDDING` | `ai/nomic-embed-text-v2-moe` |
| `MODEL_CONTEXT_SIZE` | `32768` |
| `MODEL_KEEP_ALIVE` | `-1` (тримати модель у памʼяті) |

Приклади:

```bash
make up BASALTROCK_VERSION=v0.2.0          # закріпити версію
make up BASALTROCK=../basaltrock           # локальна копія замість завантаження
make ingest DOC_ANSI_CODEPAGE=cp1252
```

## Системний промпт

Український системний промпт задається у `docker-compose.ua.yml` — це єдина відмінність від базового basaltrock. Під час редагування залиште заповнювач `{context}`.

## Ліцензія

MIT