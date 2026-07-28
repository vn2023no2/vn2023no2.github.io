---
sidebar_position: 2
---

# MCP (Model Context Protocol)

MCP là một giao thức mở do Anthropic phát triển, cho phép các AI model kết nối với các nguồn dữ liệu và công cụ bên ngoài một cách chuẩn hóa.

Hiểu đơn giản: MCP giống như **USB-C cho AI** — một chuẩn kết nối chung thay vì mỗi nơi một kiểu.

## Các thành phần chính

- **MCP Server**: cung cấp dữ liệu/công cụ (ví dụ: server đọc file, gọi API)
- **MCP Client**: AI model kết nối đến server để sử dụng công cụ
- **Transport**: cơ chế truyền thông tin (stdio, HTTP/SSE)

## Setup MCP trong VS Code

Có 3 scope để cấu hình:

| Scope | File | Mô tả |
|-------|------|--------|
| Amazon Q global | `~/.aws/amazonq/mcp.json` | Áp dụng cho tất cả project khi dùng Amazon Q |
| VS Code global | `settings.json` (user level) | Global cho VS Code native MCP (v1.99+) |
| Workspace | `.vscode/mcp.json` | Chỉ áp dụng cho repo hiện tại, có thể commit git |

**Nguyên tắc:**
- Dùng **global** cho các tool cá nhân (filesystem, browser, v.v.)
- Dùng **workspace** cho các tool liên quan đến project cụ thể (database, API nội bộ)

### Cách 1: Amazon Q global (`~/.aws/amazonq/mcp.json`)

```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/folder"]
    }
  }
}
```

Restart Amazon Q sau khi lưu file.

### Cách 2: VS Code native (`settings.json`)

Mở `Ctrl+Shift+P` → "Open User Settings (JSON)", thêm:

```json
{
  "mcp": {
    "servers": {
      "my-server": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:/Users/you/Documents"]
      }
    }
  }
}
```

> Lưu ý: Cách này chỉ hoạt động với VS Code Copilot Chat (agent mode), không phải Amazon Q.

### Cách 3: Workspace (`.vscode/mcp.json`)

```json
{
  "servers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path/to/folder"]
    }
  }
}
```

## Các loại MCP Server

### Không cần cài đặt

**npx** (gói npm):
```json
{ "command": "npx", "args": ["-y", "@modelcontextprotocol/server-filesystem", "/path"] }
```

**uvx** (gói Python, yêu cầu [uv](https://docs.astral.sh/uv/)):
```json
{ "command": "uvx", "args": ["mcp-server-name"] }
```

**Docker:**
```json
{ "command": "docker", "args": ["run", "-i", "--rm", "mcp/server-name"] }
```

### Cần cài đặt

**Binary** (download từ releases, thêm vào PATH):
```json
{ "command": "mcp-server-name" }
```

**Local build** (clone repo → build):
```json
{ "command": "node", "args": ["./dist/index.js"] }
```

**HTTP/SSE** (server đang chạy sẵn):
```json
{ "url": "http://localhost:8080/sse" }
```

### Một số server phổ biến

| Server | Package | Args |
|--------|---------|------|
| Filesystem | `@modelcontextprotocol/server-filesystem` | Đường dẫn thư mục |
| GitHub | `@modelcontextprotocol/server-github` | GitHub token |
| Postgres | `@modelcontextprotocol/server-postgres` | Connection string |
| Brave Search | `@modelcontextprotocol/server-brave-search` | API key |

Tham khảo thêm:
- https://github.com/modelcontextprotocol/servers
- https://mcp.so

## Ví dụ: Setup mcp-grafana

Source: https://github.com/grafana/mcp-grafana

`mcp-grafana` được viết bằng Go, cần download binary từ [releases page](https://github.com/grafana/mcp-grafana/releases) và thêm vào PATH.

```json
{
  "mcpServers": {
    "grafana": {
      "command": "mcp-grafana",
      "env": {
        "GRAFANA_URL": "http://localhost:3000",
        "GRAFANA_API_KEY": "<your-api-key>"
      }
    }
  }
}
```

Hoặc dùng `uvx` (không cần cài đặt thêm, yêu cầu [uv](https://docs.astral.sh/uv/) đã được cài):

```json
{
  "mcpServers": {
    "grafana": {
      "command": "uvx",
      "args": ["mcp-grafana"],
      "env": {
        "GRAFANA_URL": "http://localhost:3000",
        "GRAFANA_API_KEY": "<your-api-key>"
      }
    }
  }
}
```

**Lấy Grafana API Key:**
- Vào Grafana → `Administration` → `Service accounts` → `Add service account token`

## Ví dụ: Setup mcp-dynatrace

Source: https://github.com/dynatrace-oss/dynatrace-managed-mcp

> Dành cho Dynatrace Managed (self-hosted). Nếu dùng Dynatrace SaaS, dùng [dynatrace-mcp](https://github.com/dynatrace-oss/dynatrace-mcp).

**Dùng gói (npx):**
```json
{
  "mcpServers": {
    "dynatrace-managed": {
      "command": "npx",
      "args": ["-y", "@dynatrace-oss/dynatrace-managed-mcp-server@latest"],
      "env": { "DT_CONFIG_FILE": "./dt-config.yaml" }
    }
  }
}
```

**Cài đặt local** (clone repo → `npm install && npm run build`):
```json
{
  "mcpServers": {
    "dynatrace-managed": {
      "command": "node",
      "args": ["./dist/index.js"],
      "env": { "DT_CONFIG_FILE": "./dt-config.yaml" }
    }
  }
}
```

**File `dt-config.yaml`:**
```yaml
- dynatraceUrl: https://my-dashboard.company.com/
  apiEndpointUrl: https://my-api.company.com/
  environmentId: <env-id>
  alias: production
  apiToken: ${DT_API_TOKEN}
```

**Lấy API Token:** Dynatrace → `Settings` → `Access tokens` → `Generate new token`
- Scopes: `entities.read`, `metrics.read`, `problems.read`, `logs.read`, `slo.read`, `securityProblems.read`
