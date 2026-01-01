# Advanced Conditional Patterns

Learn advanced techniques for conditional rendering in JAC-Client.

---

## Object Lookup (Switch Alternative)

JAC-Client doesn't have switch statements. Use object lookup instead:

### JavaScript Switch

```javascript
switch (status) {
  case 'success': return <SuccessIcon />;
  case 'error': return <ErrorIcon />;
  case 'warning': return <WarningIcon />;
  default: return <InfoIcon />;
}
```

### JAC-Client Object Lookup

```jac
def StatusIcon(props: dict) -> any {
    status = props["status"];

    icons = {
        "success": <span style={{ "color": "green" }}>✓</span>,
        "error": <span style={{ "color": "red" }}>✗</span>,
        "warning": <span style={{ "color": "orange" }}>⚠</span>,
        "info": <span style={{ "color": "blue" }}>ℹ</span>
    };

    return icons[status] or icons["info"];
}
```

---

## Component Mapping

```jac
def PageRenderer(props: dict) -> any {
    page = props["page"];

    pages = {
        "home": <HomePage />,
        "about": <AboutPage />,
        "contact": <ContactPage />,
        "settings": <SettingsPage />
    };

    return (
        <div>
            {pages[page] or <NotFoundPage />}
        </div>
    );
}
```

---

## Render Props Pattern

```jac
def ConditionalWrapper(props: dict) -> any {
    # Conditionally wrap content
    if props["wrap"] {
        return (
            <div className="wrapper">
                {props["children"]}
            </div>
        );
    }

    return props["children"];
}

# Usage
<ConditionalWrapper wrap={needsWrapper}>
    <Content />
</ConditionalWrapper>
```

---

## Multiple Fragments

```jac
def ContentSections(props: dict) -> any {
    showHeader = props["showHeader"];
    showSidebar = props["showSidebar"];
    showFooter = props["showFooter"];

    return (
        <>
            {showHeader and (
                <>
                    <header>Header</header>
                    <nav>Navigation</nav>
                </>
            )}

            <main>Content</main>

            {showSidebar and (
                <>
                    <aside>Sidebar</aside>
                    <div>Related</div>
                </>
            )}

            {showFooter and <footer>Footer</footer>}
        </>
    );
}
```

---

## Conditional Attributes

```jac
def Button(props: dict) -> any {
    # Build attributes conditionally
    attrs = {
        "type": props["type"] or "button",
        "disabled": props["disabled"] or False,
        "className": props["className"] or "btn"
    };

    # Add optional attributes
    if props["id"] {
        attrs["id"] = props["id"];
    }

    return (
        <button
            type={attrs["type"]}
            disabled={attrs["disabled"]}
            className={attrs["className"]}
            id={attrs["id"]}
        >
            {props["children"]}
        </button>
    );
}
```

---

## Enum-Based Rendering

```jac
def OrderStatus(props: dict) -> any {
    status = props["status"];

    statusConfig = {
        "pending": {
            "label": "Pending",
            "color": "#ffc107",
            "icon": "⏳"
        },
        "processing": {
            "label": "Processing",
            "color": "#17a2b8",
            "icon": "⚙️"
        },
        "shipped": {
            "label": "Shipped",
            "color": "#007bff",
            "icon": "📦"
        },
        "delivered": {
            "label": "Delivered",
            "color": "#28a745",
            "icon": "✓"
        },
        "cancelled": {
            "label": "Cancelled",
            "color": "#dc3545",
            "icon": "✗"
        }
    };

    config = statusConfig[status] or statusConfig["pending"];

    return (
        <span style={{
            "backgroundColor": config["color"],
            "color": "white",
            "padding": "5px 10px",
            "borderRadius": "4px"
        }}>
            {config["icon"]} {config["label"]}
        </span>
    );
}
```

---

## Conditional List Rendering

```jac
def FilteredList(props: dict) -> any {
    items = props["items"] or [];
    filter = props["filter"];

    # Apply different filters
    filteredItems = items;

    if filter == "active" {
        filteredItems = items.filter(lambda i: dict -> bool {
            return i["active"];
        });
    } elif filter == "completed" {
        filteredItems = items.filter(lambda i: dict -> bool {
            return i["completed"];
        });
    } elif filter == "important" {
        filteredItems = items.filter(lambda i: dict -> bool {
            return i["priority"] == "high";
        });
    }

    if filteredItems.length == 0 {
        return <p>No items match the filter</p>;
    }

    return (
        <ul>
            {filteredItems.map(lambda item: dict, i: int -> any {
                return <li key={item["id"]}>{item["name"]}</li>;
            })}
        </ul>
    );
}
```

---

## Polymorphic Components

```jac
def Text(props: dict) -> any {
    variant = props["variant"] or "p";

    # Different elements based on variant
    if variant == "h1" {
        return <h1>{props["children"]}</h1>;
    } elif variant == "h2" {
        return <h2>{props["children"]}</h2>;
    } elif variant == "h3" {
        return <h3>{props["children"]}</h3>;
    } elif variant == "span" {
        return <span>{props["children"]}</span>;
    } else {
        return <p>{props["children"]}</p>;
    }
}

# Usage
<Text variant="h1">Title</Text>
<Text variant="p">Paragraph</Text>
<Text>Default paragraph</Text>
```

---

## Conditional Rendering with Hooks

```jac
def DataDisplay() -> any {
    [view, setView] = useState("list");
    [data, setData] = useState([]);

    # Different views
    if view == "list" {
        return (
            <div>
                <ViewToggle current={view} onChange={lambda v: str -> None { setView(v); }} />
                <ListView data={data} />
            </div>
        );
    } elif view == "grid" {
        return (
            <div>
                <ViewToggle current={view} onChange={lambda v: str -> None { setView(v); }} />
                <GridView data={data} />
            </div>
        );
    } elif view == "table" {
        return (
            <div>
                <ViewToggle current={view} onChange={lambda v: str -> None { setView(v); }} />
                <TableView data={data} />
            </div>
        );
    }

    return <></>;
}
```

---

## Compound Conditions

```jac
def Dashboard(props: dict) -> any {
    user = props["user"];
    settings = props["settings"];

    isAdmin = user["role"] == "admin";
    isPremium = user["subscription"] == "premium";
    hasNotifications = user["notifications"] > 0;
    darkMode = settings["theme"] == "dark";

    return (
        <div className={("dark") if darkMode else ("light")}>
            {# Admin features #}
            {isAdmin and (
                <>
                    <AdminPanel />
                    <UserManagement />
                </>
            )}

            {# Premium features #}
            {isPremium and not isAdmin and (
                <PremiumFeatures />
            )}

            {# Notifications - all users #}
            {hasNotifications and (
                <NotificationBadge count={user["notifications"]} />
            )}

            {# Basic content - always shown #}
            <MainContent />
        </div>
    );
}
```

---

## Summary

| Pattern | Use Case |
|---------|----------|
| Object lookup | Replace switch statements |
| Component mapping | Route-like rendering |
| Fragments | Group conditional elements |
| Enum config | Status/state display |
| Polymorphic | Different HTML elements |
| Compound | Complex permission logic |

---

## Next Section

- [Lists and Loops](../07-lists-and-loops/) - For loops, array methods
