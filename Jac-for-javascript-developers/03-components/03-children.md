# Children and Composition

Learn how to compose components and pass children in JAC-Client.

---

## Children Basics

### JavaScript/React

```jsx
function Card({ children }) {
  return <div className="card">{children}</div>;
}

<Card>
  <h1>Title</h1>
  <p>Content</p>
</Card>
```

### JAC-Client

```jac
def Card(props: dict) -> any {
    return (
        <div style={{ "border": "1px solid #ccc", "padding": "15px" }}>
            {props["children"]}
        </div>
    );
}

<Card>
    <h1>Title</h1>
    <p>Content</p>
</Card>
```

Children are passed as `props["children"]`.

---

## Wrapper Components

### Layout Wrapper

```jac
def PageLayout(props: dict) -> any {
    return (
        <div style={{ "maxWidth": "1200px", "margin": "0 auto" }}>
            <header style={{ "padding": "20px", "backgroundColor": "#f5f5f5" }}>
                <h1>My App</h1>
            </header>
            <main style={{ "padding": "20px" }}>
                {props["children"]}
            </main>
            <footer style={{ "padding": "20px", "backgroundColor": "#333", "color": "white" }}>
                Footer
            </footer>
        </div>
    );
}

# Usage
def app() -> any {
    return (
        <PageLayout>
            <h2>Welcome</h2>
            <p>This is the content area.</p>
        </PageLayout>
    );
}
```

### Card Wrapper

```jac
def Card(props: dict) -> any {
    return (
        <div style={{
            "backgroundColor": "white",
            "borderRadius": "8px",
            "boxShadow": "0 2px 4px rgba(0,0,0,0.1)",
            "padding": "20px",
            "marginBottom": "20px"
        }}>
            {props["title"] and <h3>{props["title"]}</h3>}
            {props["children"]}
        </div>
    );
}

# Usage
<Card title="User Profile">
    <p>Name: John Doe</p>
    <p>Email: john@example.com</p>
</Card>
```

---

## Conditional Children

```jac
def Modal(props: dict) -> any {
    if not props["isOpen"] {
        return <></>;
    }

    return (
        <div style={{
            "position": "fixed",
            "top": "0",
            "left": "0",
            "right": "0",
            "bottom": "0",
            "backgroundColor": "rgba(0,0,0,0.5)",
            "display": "flex",
            "alignItems": "center",
            "justifyContent": "center"
        }}>
            <div style={{
                "backgroundColor": "white",
                "padding": "20px",
                "borderRadius": "8px",
                "minWidth": "300px"
            }}>
                <button
                    onClick={props["onClose"]}
                    style={{ "float": "right" }}
                >
                    X
                </button>
                {props["children"]}
            </div>
        </div>
    );
}

# Usage
def app() -> any {
    [isOpen, setIsOpen] = useState(False);

    return (
        <div>
            <button onClick={lambda: setIsOpen(True)}>Open Modal</button>

            <Modal isOpen={isOpen} onClose={lambda: setIsOpen(False)}>
                <h2>Modal Title</h2>
                <p>Modal content goes here.</p>
            </Modal>
        </div>
    );
}
```

---

## Multiple Children Slots

### Using Props for Named Slots

```jac
def Layout(props: dict) -> any {
    return (
        <div style={{ "display": "grid", "gridTemplateRows": "auto 1fr auto" }}>
            <header>{props["header"]}</header>
            <main>{props["children"]}</main>
            <footer>{props["footer"]}</footer>
        </div>
    );
}

# Usage
<Layout
    header={<nav>Navigation</nav>}
    footer={<p>Copyright 2024</p>}
>
    <article>Main content</article>
</Layout>
```

### Sidebar Layout

```jac
def SidebarLayout(props: dict) -> any {
    return (
        <div style={{ "display": "flex" }}>
            <aside style={{ "width": "250px", "backgroundColor": "#f5f5f5" }}>
                {props["sidebar"]}
            </aside>
            <main style={{ "flex": "1", "padding": "20px" }}>
                {props["children"]}
            </main>
        </div>
    );
}

# Usage
<SidebarLayout
    sidebar={
        <nav>
            <a href="/">Home</a>
            <a href="/about">About</a>
        </nav>
    }
>
    <h1>Page Content</h1>
    <p>Main content area.</p>
</SidebarLayout>
```

---

## Composing Components

### Small, Focused Components

```jac
cl import from react { useState }

cl {
    # Small, reusable button
    def IconButton(props: dict) -> any {
        return (
            <button
                onClick={props["onClick"]}
                style={{
                    "padding": "8px 12px",
                    "border": "none",
                    "borderRadius": "4px",
                    "cursor": "pointer",
                    "backgroundColor": props["color"] or "#007bff",
                    "color": "white"
                }}
            >
                {props["icon"]} {props["label"]}
            </button>
        );
    }

    # Composed toolbar
    def Toolbar(props: dict) -> any {
        return (
            <div style={{ "display": "flex", "gap": "10px", "marginBottom": "20px" }}>
                {props["children"]}
            </div>
        );
    }

    # Usage
    def Editor() -> any {
        [content, setContent] = useState("");

        return (
            <div>
                <Toolbar>
                    <IconButton icon="B" label="Bold" onClick={lambda: console.log("bold")} />
                    <IconButton icon="I" label="Italic" onClick={lambda: console.log("italic")} />
                    <IconButton icon="U" label="Underline" onClick={lambda: console.log("underline")} />
                </Toolbar>
                <textarea
                    value={content}
                    onChange={lambda e: any -> None { setContent(e.target.value); }}
                    style={{ "width": "100%", "height": "200px" }}
                />
            </div>
        );
    }

    def app() -> any {
        return <Editor />;
    }
}
```

---

## Higher-Order Components Pattern

### Wrapping Components

```jac
def withLoading(WrappedComponent: any) -> any {
    def WithLoadingComponent(props: dict) -> any {
        if props["isLoading"] {
            return <p>Loading...</p>;
        }
        return <WrappedComponent {...props} />;
    }
    return WithLoadingComponent;
}

# Note: This pattern is less common in JAC-Client
# Prefer composition with children instead
```

---

## Render Props Pattern

```jac
def MouseTracker(props: dict) -> any {
    [position, setPosition] = useState({ "x": 0, "y": 0 });

    def handleMouseMove(e: any) -> None {
        setPosition({ "x": e.clientX, "y": e.clientY });
    }

    return (
        <div
            onMouseMove={handleMouseMove}
            style={{ "height": "100vh" }}
        >
            {props["render"](position)}
        </div>
    );
}

# Usage
<MouseTracker render={lambda pos: dict -> any {
    return <p>Mouse: {pos["x"]}, {pos["y"]}</p>;
}} />
```

---

## Component List Patterns

### Mapping Children Alternatives

```jac
def List(props: dict) -> any {
    items = props["items"] or [];

    def renderItem(item: dict, index: int) -> any {
        return (
            <li key={item["id"]} style={{ "padding": "10px" }}>
                {item["name"]}
            </li>
        );
    }

    return <ul>{items.map(renderItem)}</ul>;
}

# Usage
<List items={[
    { "id": 1, "name": "Item 1" },
    { "id": 2, "name": "Item 2" },
    { "id": 3, "name": "Item 3" }
]} />
```

### Custom Item Renderer

```jac
def List(props: dict) -> any {
    items = props["items"] or [];
    renderItem = props["renderItem"];

    def defaultRender(item: any, index: int) -> any {
        return <li key={index}>{item}</li>;
    }

    renderer = renderItem or defaultRender;

    return <ul>{items.map(renderer)}</ul>;
}

# Usage with custom renderer
<List
    items={users}
    renderItem={lambda user: dict, index: int -> any {
        return (
            <li key={user["id"]}>
                <strong>{user["name"]}</strong> - {user["email"]}
            </li>
        );
    }}
/>
```

---

## Summary

| Pattern | Description |
|---------|-------------|
| `props["children"]` | Access nested children |
| Named slots | Pass components as props |
| Wrapper components | Use children for content |
| Conditional render | Show/hide based on props |
| Composition | Build complex from simple |

---

## Next

- [JSX in JAC](04-jsx-in-jac.md) - JSX syntax differences
