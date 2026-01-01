# JAC-Client for JavaScript Developers

A comprehensive guide for JavaScript developers transitioning to JAC-Client. If you know JavaScript/React, you're 80% there - this guide covers the 20% that's different.

---

## Table of Contents

1. [Introduction & Quick Start](#1-introduction--quick-start)
2. [Core Syntax Differences](#2-core-syntax-differences)
3. [Components](#3-components)
4. [Lambda Functions (Arrow Functions)](#4-lambda-functions-arrow-functions)
5. [State with React Hooks](#5-state-with-react-hooks)
6. [Event Handling](#6-event-handling)
7. [Conditional Rendering](#7-conditional-rendering)
8. [Lists, Loops & Array Methods](#8-lists-loops--array-methods)
9. [Routing](#9-routing)
10. [Forms](#10-forms)
11. [Styling](#11-styling)
12. [State Management Libraries](#12-state-management-libraries)
13. [Authentication](#13-authentication)
14. [Quick Reference Cheat Sheet](#14-quick-reference-cheat-sheet)

---

## 1. Introduction & Quick Start

### What is JAC-Client?

JAC-Client lets you write React applications using JAC syntax - a Python-inspired language that compiles to JavaScript. You get:

- **React under the hood** - Same hooks, same JSX, same component model
- **Python-like syntax** - Cleaner, more readable code
- **Full-stack capability** - Frontend and backend in one language (this guide focuses on frontend)

### TL;DR - The Key Differences

Before diving deep, here's what's different at a glance:

| Concept | React/JavaScript | JAC-Client |
|---------|-----------------|------------|
| **Variable** | `const x = 5` | `x = 5` |
| **State** | `const [x, setX] = useState(0)` | `[x, setX] = useState(0)` |
| **Function** | `function App() { }` | `def app() -> any { }` |
| **Arrow function** | `() => { }` | `lambda -> None { }` |
| **Arrow with param** | `(x) => x * 2` | `lambda x: int -> int { return x * 2; }` |
| **Ternary** | `a ? b : c` | `(b) if a else (c)` |
| **AND** | `&&` | `and` |
| **OR** | `\|\|` | `or` |
| **NOT** | `!` | `not` |
| **Boolean** | `true / false` | `True / False` |
| **Null** | `null` | `None` |
| **Object** | `{ key: value }` | `{ "key": value }` |
| **Property access** | `obj.key` | `obj["key"]` |
| **For loop** | `for(let i=0; i<5; i++)` | `for i=0 to i<5 by i+=1` |
| **For-of** | `for(x of arr)` | `for x in arr` |
| **Return nothing** | `return null` | `return <></>` |
| **Import** | `import { x } from 'lib'` | `cl import from lib { x }` |
| **Comment** | `// comment` | `# comment` |

### Your First JAC-Client Component

**React:**
```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}

export default function App() {
  return <Counter />;
}
```

**JAC-Client:**
```jac
cl import from react { useState }

cl {
    def Counter() -> any {
        [count, setCount] = useState(0);

        return (
            <div>
                <p>Count: {count}</p>
                <button onClick={lambda: setCount(count + 1)}>
                    Increment
                </button>
            </div>
        );
    }

    def app() -> any {
        return <Counter />;
    }
}
```

**Key differences in this example:**
1. `cl import from react` instead of `import from 'react'`
2. `cl { }` block wraps all client-side code
3. `def Counter() -> any` instead of `function Counter()`
4. `[count, setCount] = useState(0)` - no `const`
5. `lambda: setCount(count + 1)` instead of `() => setCount(count + 1)`
6. `def app()` is the entry point (like `App` in React)

---

## 2. Core Syntax Differences

### Variables - No `let` or `const`

In JAC-Client, you don't use `let` or `const`. Just assign directly.

**React:**
```jsx
const name = "John";
let count = 0;
const [value, setValue] = useState("");
```

**JAC-Client:**
```jac
name = "John";
count = 0;
[value, setValue] = useState("");
```

### Functions - Use `def` with Return Types

**React:**
```jsx
function greet(name) {
  return `Hello, ${name}!`;
}

const add = (a, b) => a + b;
```

**JAC-Client:**
```jac
def greet(name: str) -> str {
    return "Hello, " + name + "!";
}

# For simple expressions, use lambda
add = lambda a: int, b: int -> int { return a + b; };
```

### Booleans - Capitalized

**React:**
```jsx
const isActive = true;
const isHidden = false;
```

**JAC-Client:**
```jac
isActive = True;
isHidden = False;
```

### Null - Use `None`

**React:**
```jsx
const data = null;
if (value === null) { ... }
```

**JAC-Client:**
```jac
data = None;
if value == None { ... }
```

### Comments - Use `#`

**React:**
```jsx
// This is a comment
/* Multi-line
   comment */
```

**JAC-Client:**
```jac
# This is a comment
# Multi-line comments
# use multiple # symbols
```

### Object Keys - Must Be Quoted Strings

This is important for style objects and data structures.

**React:**
```jsx
const style = { padding: "10px", marginTop: "5px" };
const user = { name: "John", age: 25 };
console.log(user.name);
```

**JAC-Client:**
```jac
style = { "padding": "10px", "marginTop": "5px" };
user = { "name": "John", "age": 25 };
console.log(user["name"]);
```

---

## 3. Components

### Basic Component Definition

**React:**
```jsx
function Greeting() {
  return <h1>Hello, World!</h1>;
}
```

**JAC-Client:**
```jac
def Greeting() -> any {
    return <h1>Hello, World!</h1>;
}
```

### The `app()` Entry Point

In JAC-Client, `app()` is the entry point (similar to `App` in React):

```jac
cl import from react { useState }

cl {
    def Header() -> any {
        return <header><h1>My App</h1></header>;
    }

    def Content() -> any {
        return <main><p>Welcome!</p></main>;
    }

    # This is the entry point - required!
    def app() -> any {
        return (
            <div>
                <Header />
                <Content />
            </div>
        );
    }
}
```

### Components with Props

**React:**
```jsx
function UserCard({ name, age, isActive }) {
  return (
    <div>
      <h2>{name}</h2>
      <p>Age: {age}</p>
      <p>Status: {isActive ? "Active" : "Inactive"}</p>
    </div>
  );
}

// Usage
<UserCard name="John" age={25} isActive={true} />
```

**JAC-Client:**
```jac
def UserCard(props: dict) -> any {
    return (
        <div>
            <h2>{props["name"]}</h2>
            <p>Age: {props["age"]}</p>
            <p>Status: {("Active") if props["isActive"] else ("Inactive")}</p>
        </div>
    );
}

# Usage
<UserCard name="John" age={25} isActive={True} />
```

**Key difference:** Props are accessed via `props["key"]` not `props.key` or destructuring.

---

## 4. Lambda Functions (Arrow Functions)

This is the **biggest syntax difference** from React. Master this and you've mastered JAC-Client.

### Quick Comparison Table

| Pattern | React | JAC-Client |
|---------|-------|------------|
| No params, no return | `() => { doSomething(); }` | `lambda -> None { doSomething(); }` |
| No params, short | `() => doSomething()` | `lambda: doSomething()` |
| One param | `(x) => { return x * 2; }` | `lambda x: int -> int { return x * 2; }` |
| One param, short | `x => x * 2` | N/A - use full form |
| Multiple params | `(a, b) => a + b` | `lambda a: int, b: int -> int { return a + b; }` |
| Event handler | `(e) => { e.preventDefault(); }` | `lambda e: any -> None { e.preventDefault(); }` |

### No Parameters

**React:**
```jsx
onClick={() => setCount(count + 1)}
onClick={() => {
  setCount(count + 1);
  console.log("clicked");
}}
```

**JAC-Client:**
```jac
# Short form (single expression)
onClick={lambda: setCount(count + 1)}

# Full form (multiple statements)
onClick={lambda -> None {
    setCount(count + 1);
    console.log("clicked");
}}
```

### Single Parameter

**React:**
```jsx
onChange={(e) => setName(e.target.value)}
numbers.map((n) => n * 2)
```

**JAC-Client:**
```jac
onChange={lambda e: any -> None { setName(e.target.value); }}

# For map, define a helper function
def double(n: int, index: int) -> int {
    return n * 2;
}
numbers.map(double)
```

### Multiple Parameters

**React:**
```jsx
const add = (a, b) => a + b;
items.reduce((acc, item) => acc + item.price, 0);
```

**JAC-Client:**
```jac
add = lambda a: int, b: int -> int { return a + b; };

# For reduce
def sumPrices(acc: float, item: dict) -> float {
    return acc + item["price"];
}
items.reduce(sumPrices, 0);
```

### Complex onClick with Multiple Actions

**React:**
```jsx
<button onClick={() => {
  setCount(count + 1);
  setMessage("Clicked!");
  console.log("Button clicked");
}}>
  Click Me
</button>
```

**JAC-Client:**
```jac
<button onClick={lambda -> None {
    setCount(count + 1);
    setMessage("Clicked!");
    console.log("Button clicked");
}}>
    Click Me
</button>
```

### Conditional Logic in Lambda

**React:**
```jsx
<button onClick={() => {
  if (isValid) {
    submit();
  } else {
    showError();
  }
}}>
  Submit
</button>
```

**JAC-Client:**
```jac
<button onClick={lambda -> None {
    if isValid {
        submit();
    } else {
        showError();
    }
}}>
    Submit
</button>
```

### Lambda in useEffect

**React:**
```jsx
useEffect(() => {
  console.log("Component mounted");
  return () => console.log("Cleanup");
}, []);
```

**JAC-Client:**
```jac
useEffect(lambda -> None {
    console.log("Component mounted");
    return lambda -> None { console.log("Cleanup"); };
}, []);
```

### Lambda in useCallback

**React:**
```jsx
const handleClick = useCallback(() => {
  setCount(count + 1);
}, [count]);
```

**JAC-Client:**
```jac
handleClick = useCallback(
    lambda -> None { setCount(count + 1); },
    [count]
);
```

---

## 5. State with React Hooks

### useState

**React:**
```jsx
const [count, setCount] = useState(0);
const [name, setName] = useState("");
const [items, setItems] = useState([]);
const [user, setUser] = useState({ name: "", age: 0 });
```

**JAC-Client:**
```jac
[count, setCount] = useState(0);
[name, setName] = useState("");
[items, setItems] = useState([]);
[user, setUser] = useState({ "name": "", "age": 0 });
```

### useEffect

**React:**
```jsx
// On mount
useEffect(() => {
  fetchData();
}, []);

// On dependency change
useEffect(() => {
  console.log("Count changed:", count);
}, [count]);

// With cleanup
useEffect(() => {
  const timer = setInterval(() => tick(), 1000);
  return () => clearInterval(timer);
}, []);
```

**JAC-Client:**
```jac
# On mount
useEffect(lambda -> None {
    fetchData();
}, []);

# On dependency change
useEffect(lambda -> None {
    console.log("Count changed:", count);
}, [count]);

# With cleanup
useEffect(lambda -> None {
    timer = setInterval(lambda -> None { tick(); }, 1000);
    return lambda -> None { clearInterval(timer); };
}, []);
```

### useCallback & useMemo

**React:**
```jsx
const memoizedCallback = useCallback(() => {
  doSomething(a, b);
}, [a, b]);

const memoizedValue = useMemo(() => {
  return expensiveCalculation(a, b);
}, [a, b]);
```

**JAC-Client:**
```jac
memoizedCallback = useCallback(
    lambda -> None { doSomething(a, b); },
    [a, b]
);

memoizedValue = useMemo(
    lambda -> any { return expensiveCalculation(a, b); },
    [a, b]
);
```

### useRef

**React:**
```jsx
const inputRef = useRef(null);
// Usage: inputRef.current.focus();
```

**JAC-Client:**
```jac
inputRef = useRef(None);
# Usage: inputRef.current.focus();
```

---

## 6. Event Handling

### onClick

**React:**
```jsx
<button onClick={() => handleClick()}>Click</button>
<button onClick={(e) => handleClick(e)}>Click</button>
<button onClick={() => handleClick(id, name)}>Click</button>
```

**JAC-Client:**
```jac
<button onClick={lambda: handleClick()}>Click</button>
<button onClick={lambda e: any -> None { handleClick(e); }}>Click</button>
<button onClick={lambda: handleClick(id, name)}>Click</button>
```

### onChange

**React:**
```jsx
<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

**JAC-Client:**
```jac
<input
    value={name}
    onChange={lambda e: any -> None { setName(e.target.value); }}
/>
```

### onSubmit

**React:**
```jsx
<form onSubmit={(e) => {
  e.preventDefault();
  handleSubmit();
}}>
```

**JAC-Client:**
```jac
<form onSubmit={lambda e: any -> None {
    e.preventDefault();
    handleSubmit();
}}>
```

### Complete Form Example

**React:**
```jsx
function LoginForm() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();
    login(email, password);
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
      />
      <input
        type="password"
        value={password}
        onChange={(e) => setPassword(e.target.value)}
      />
      <button type="submit">Login</button>
    </form>
  );
}
```

**JAC-Client:**
```jac
def LoginForm() -> any {
    [email, setEmail] = useState("");
    [password, setPassword] = useState("");

    def handleSubmit(e: any) -> None {
        e.preventDefault();
        login(email, password);
    }

    return (
        <form onSubmit={handleSubmit}>
            <input
                type="email"
                value={email}
                onChange={lambda e: any -> None { setEmail(e.target.value); }}
            />
            <input
                type="password"
                value={password}
                onChange={lambda e: any -> None { setPassword(e.target.value); }}
            />
            <button type="submit">Login</button>
        </form>
    );
}
```

---

## 7. Conditional Rendering

### Ternary Operator (Python Style!)

This is one of the **most confusing differences** for JavaScript developers.

**React (JavaScript ternary):**
```jsx
{isLoggedIn ? <Dashboard /> : <Login />}
{count > 0 ? "Positive" : "Zero or negative"}
```

**JAC-Client (Python ternary):**
```jac
{(<Dashboard />) if isLoggedIn else (<Login />)}
{("Positive") if count > 0 else ("Zero or negative")}
```

**Important:** Always wrap JSX elements in parentheses when using ternary!

```jac
# Correct
{(<span>Yes</span>) if condition else (<span>No</span>)}

# Wrong - will cause errors
{<span>Yes</span> if condition else <span>No</span>}
```

### Logical AND

**React:**
```jsx
{isLoggedIn && <Dashboard />}
{count > 0 && <p>Count is positive</p>}
```

**JAC-Client:**
```jac
{isLoggedIn and <Dashboard />}
{count > 0 and <p>Count is positive</p>}
```

### Logical OR (Default Values)

**React:**
```jsx
{username || "Guest"}
{data || "Loading..."}
```

**JAC-Client:**
```jac
{username or "Guest"}
{data or "Loading..."}
```

### Logical NOT

**React:**
```jsx
{!isLoading && <Content />}
{!error && <Success />}
```

**JAC-Client:**
```jac
{not isLoading and <Content />}
{not error and <Success />}
```

### If-Else in Component Body

**React:**
```jsx
function Status({ status }) {
  if (status === "loading") {
    return <p>Loading...</p>;
  }
  if (status === "error") {
    return <p>Error!</p>;
  }
  return <p>Success!</p>;
}
```

**JAC-Client:**
```jac
def Status(status: str) -> any {
    if status == "loading" {
        return <p>Loading...</p>;
    }
    if status == "error" {
        return <p>Error!</p>;
    }
    return <p>Success!</p>;
}
```

### Rendering Nothing

**React:**
```jsx
if (!shouldShow) {
  return null;
}
```

**JAC-Client:**
```jac
if not shouldShow {
    return <></>;  # Empty fragment
}
```

### Object/Dictionary Lookup Pattern

Instead of switch statements (not supported in JAC-Client), use object lookup:

**React:**
```jsx
const statusConfig = {
  success: { color: "green", icon: "✓", text: "Success" },
  error: { color: "red", icon: "✗", text: "Error" },
  loading: { color: "blue", icon: "⏳", text: "Loading" }
};

const config = statusConfig[status] || statusConfig.loading;
```

**JAC-Client:**
```jac
statusConfig = {
    "success": { "color": "green", "icon": "✓", "text": "Success" },
    "error": { "color": "red", "icon": "✗", "text": "Error" },
    "loading": { "color": "blue", "icon": "⏳", "text": "Loading" }
};

config = statusConfig[status] if status in statusConfig else statusConfig["loading"];
```

---

## 8. Lists, Loops & Array Methods

### For Loops

JAC-Client uses a unique for loop syntax. **Note: `range()` does NOT work!**

**React:**
```jsx
for (let i = 0; i < 5; i++) {
  console.log(i);
}
```

**JAC-Client:**
```jac
for i=0 to i<5 by i+=1 {
    console.log(i);
}

# Inclusive end (1 to 5)
for i=1 to i<=5 by i+=1 {
    console.log(i);  # 1, 2, 3, 4, 5
}

# Custom step
for i=0 to i<=10 by i+=2 {
    console.log(i);  # 0, 2, 4, 6, 8, 10
}

# Countdown
for i=5 to i>=0 by i-=1 {
    console.log(i);  # 5, 4, 3, 2, 1, 0
}
```

### For-In Loop (Iterate Arrays)

**React:**
```jsx
for (const item of items) {
  console.log(item);
}
```

**JAC-Client:**
```jac
for item in items {
    console.log(item);
}
```

### While Loop

**React:**
```jsx
while (count < 10) {
  count++;
}
```

**JAC-Client:**
```jac
while count < 10 {
    count = count + 1;
}
```

### Rendering Lists with .map()

**React:**
```jsx
{items.map((item, index) => (
  <li key={index}>{item}</li>
))}
```

**JAC-Client:**
```jac
# Define a helper function for map
def renderItem(item: str, index: int) -> any {
    return <li key={index}>{item}</li>;
}

{items.map(renderItem)}

# Or inline with lambda
{items.map(lambda item: str, index: int -> any {
    return <li key={index}>{item}</li>;
})}
```

### Array Methods

All JavaScript array methods work, but callbacks use lambda syntax:

#### filter

**React:**
```jsx
const evens = numbers.filter(n => n % 2 === 0);
```

**JAC-Client:**
```jac
evens = numbers.filter(lambda n: int -> bool { return n % 2 == 0; });
```

#### find

**React:**
```jsx
const adult = users.find(u => u.age >= 18);
```

**JAC-Client:**
```jac
adult = users.find(lambda u: dict -> bool { return u["age"] >= 18; });
```

#### some & every

**React:**
```jsx
const hasAdults = users.some(u => u.age >= 18);
const allAdults = users.every(u => u.age >= 18);
```

**JAC-Client:**
```jac
hasAdults = users.some(lambda u: dict -> bool { return u["age"] >= 18; });
allAdults = users.every(lambda u: dict -> bool { return u["age"] >= 18; });
```

#### reduce

**React:**
```jsx
const total = prices.reduce((acc, price) => acc + price, 0);
```

**JAC-Client:**
```jac
total = prices.reduce(lambda acc: float, price: float -> float {
    return acc + price;
}, 0);
```

#### sort

**React:**
```jsx
const sorted = [...items].sort((a, b) => a - b);
```

**JAC-Client:**
```jac
sorted = items.slice().sort(lambda a: int, b: int -> int { return a - b; });
```

### Chaining Array Methods

**React:**
```jsx
const result = items
  .filter(item => item.inStock)
  .map(item => item.name);
```

**JAC-Client:**
```jac
inStock = items.filter(lambda item: dict -> bool { return item["inStock"]; });
result = inStock.map(lambda item: dict -> str { return item["name"]; });
```

### Adding/Removing Items (Immutable)

**React:**
```jsx
// Add
setItems([...items, newItem]);

// Remove by index
setItems(items.filter((_, i) => i !== indexToRemove));
```

**JAC-Client:**
```jac
# Add
setItems(items.concat([newItem]));

# Remove by index
setItems(items.filter(lambda item: any, i: int -> bool { return i != indexToRemove; }));
```

### Spread Operator

**React:**
```jsx
const copy = [...original];
const merged = [...arr1, ...arr2];
```

**JAC-Client:**
```jac
copy = [*original];
merged = [*arr1, *arr2];
```

---

## 9. Routing

JAC-Client uses React Router under the hood.

### Setup

**React:**
```jsx
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';
```

**JAC-Client:**
```jac
cl import from react_router { Router, Routes, Route, Link, useNavigate, useParams, useLocation }
```

### Basic Routing

**React:**
```jsx
function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">Home</Link>
        <Link to="/about">About</Link>
      </nav>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  );
}
```

**JAC-Client:**
```jac
def app() -> any {
    return (
        <Router>
            <nav>
                <Link to="/">Home</Link>
                <Link to="/about">About</Link>
            </nav>
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/about" element={<About />} />
                <Route path="*" element={<NotFound />} />
            </Routes>
        </Router>
    );
}
```

### useNavigate (Programmatic Navigation)

**React:**
```jsx
const navigate = useNavigate();
const handleClick = () => navigate('/dashboard');
```

**JAC-Client:**
```jac
navigate = useNavigate();
def handleClick() -> None {
    navigate("/dashboard");
}
```

### useParams (URL Parameters)

**React:**
```jsx
// Route: /user/:id
const { id } = useParams();
```

**JAC-Client:**
```jac
# Route: /user/:id
params = useParams();
id = params.id;
```

### useLocation

**React:**
```jsx
const location = useLocation();
console.log(location.pathname);
```

**JAC-Client:**
```jac
location = useLocation();
console.log(location.pathname);
```

### Protected Routes

**JAC-Client:**
```jac
cl import from "@jac-client/utils" { jacIsLoggedIn, Navigate }

def ProtectedRoute(children: any) -> any {
    if not jacIsLoggedIn() {
        return <Navigate to="/login" />;
    }
    return children;
}

# Usage in routes
<Route path="/dashboard" element={<ProtectedRoute><Dashboard /></ProtectedRoute>} />
```

---

## 10. Forms

### Controlled Inputs

**React:**
```jsx
const [name, setName] = useState("");

<input
  value={name}
  onChange={(e) => setName(e.target.value)}
/>
```

**JAC-Client:**
```jac
[name, setName] = useState("");

<input
    value={name}
    onChange={lambda e: any -> None { setName(e.target.value); }}
/>
```

### Form Submission

**React:**
```jsx
const handleSubmit = (e) => {
  e.preventDefault();
  console.log({ name, email });
};

<form onSubmit={handleSubmit}>
  ...
</form>
```

**JAC-Client:**
```jac
def handleSubmit(e: any) -> None {
    e.preventDefault();
    console.log({ "name": name, "email": email });
}

<form onSubmit={handleSubmit}>
    ...
</form>
```

### React Hook Form Integration

**JAC-Client:**
```jac
cl import from "react-hook-form" { useForm }
cl import from "@hookform/resolvers/zod" { zodResolver }
cl import from zod { z }

# Define schema
schema = z.object({
    "username": z.string().min(3, "Username must be at least 3 characters"),
    "email": z.string().email("Invalid email"),
    "password": z.string().min(6, "Password must be at least 6 characters")
});

def RegistrationForm() -> any {
    form = useForm({
        "resolver": zodResolver(schema),
        "defaultValues": {
            "username": "",
            "email": "",
            "password": ""
        }
    });

    register = form.register;
    handleSubmit = form.handleSubmit;
    errors = form.formState.errors;

    def onSubmit(data: any) -> None {
        console.log("Form data:", data);
    }

    return (
        <form onSubmit={handleSubmit(onSubmit)}>
            <div>
                <input {...register("username")} placeholder="Username" />
                {errors.username and (
                    <span style={{"color": "red"}}>{errors.username.message}</span>
                )}
            </div>
            <div>
                <input {...register("email")} placeholder="Email" />
                {errors.email and (
                    <span style={{"color": "red"}}>{errors.email.message}</span>
                )}
            </div>
            <div>
                <input type="password" {...register("password")} placeholder="Password" />
                {errors.password and (
                    <span style={{"color": "red"}}>{errors.password.message}</span>
                )}
            </div>
            <button type="submit">Register</button>
        </form>
    );
}
```

---

## 11. Styling

### Inline Styles

Remember: Object keys must be quoted strings!

**React:**
```jsx
<div style={{ padding: "10px", backgroundColor: "#f0f0f0" }}>
```

**JAC-Client:**
```jac
<div style={{ "padding": "10px", "backgroundColor": "#f0f0f0" }}>
```

### Dynamic Styles

**React:**
```jsx
<button style={{
  backgroundColor: isActive ? "green" : "gray",
  padding: "10px"
}}>
```

**JAC-Client:**
```jac
<button style={{
    "backgroundColor": ("green") if isActive else ("gray"),
    "padding": "10px"
}}>
```

### Tailwind CSS

Works exactly the same:

**JAC-Client:**
```jac
cl import "./global.css"  # Contains @import "tailwindcss"

def Button() -> any {
    return (
        <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
            Click Me
        </button>
    );
}
```

### Styled-Components

**styled.js (JavaScript file):**
```javascript
import styled from 'styled-components';

export const Button = styled.button`
  background-color: ${props => props.primary ? "blue" : "gray"};
  color: white;
  padding: 10px 20px;
  border-radius: 5px;
`;
```

**JAC-Client:**
```jac
cl import from "./styled" { Button }

def app() -> any {
    return (
        <div>
            <Button primary={True}>Primary Button</Button>
            <Button>Secondary Button</Button>
        </div>
    );
}
```

### CSS Imports

**JAC-Client:**
```jac
cl import "./styles.css"
```

---

## 12. State Management Libraries

### Zustand

**store.jac:**
```jac
cl import from zustand { create }

counterStore = create(lambda setState: any -> dict {
    return {
        "count": 0,
        "increment": lambda -> None {
            setState(lambda state: any -> dict {
                return { "count": state.count + 1 };
            });
        },
        "decrement": lambda -> None {
            setState(lambda state: any -> dict {
                return { "count": state.count - 1 };
            });
        },
        "reset": lambda -> None {
            setState({ "count": 0 });
        }
    };
});

def useCounterStore(selector: any = None) -> any {
    if selector {
        return counterStore(selector);
    }
    return counterStore();
}
```

**app.jac:**
```jac
cl import from "./store" { useCounterStore }

def Counter() -> any {
    count = useCounterStore(lambda state: any { return state.count; });
    increment = useCounterStore(lambda state: any { return state.increment; });
    decrement = useCounterStore(lambda state: any { return state.decrement; });

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={lambda -> None { decrement(); }}>-</button>
            <button onClick={lambda -> None { increment(); }}>+</button>
        </div>
    );
}
```

### Redux Toolkit

**slice.jac:**
```jac
cl import from "@reduxjs/toolkit" { createSlice }

todoSlice = createSlice({
    "name": "todos",
    "initialState": {
        "items": []
    },
    "reducers": {
        "addTodo": lambda state: any, action: any -> None {
            newTodo = {
                "id": Date.now(),
                "text": action.payload,
                "completed": False
            };
            state.items.push(newTodo);
        },
        "toggleTodo": lambda state: any, action: any -> None {
            todo = state.items.find(lambda t: any -> bool {
                return t.id == action.payload;
            });
            if todo {
                todo.completed = not todo.completed;
            }
        }
    }
});

def getTodoActions() -> any {
    return todoSlice.actions;
}

def getTodoReducer() -> any {
    return todoSlice.reducer;
}
```

**store.jac:**
```jac
cl import from "@reduxjs/toolkit" { configureStore }
cl import from "./slice" { getTodoReducer, getTodoActions }

todoReducer = getTodoReducer();
actions = getTodoActions();

_store = configureStore({
    "reducer": {
        "todos": todoReducer
    }
});

def store() -> any {
    return _store;
}

def addTodo() -> any {
    return actions.addTodo;
}

def toggleTodo() -> any {
    return actions.toggleTodo;
}
```

**app.jac:**
```jac
cl import from "react-redux" { Provider, useSelector, useDispatch }
cl import from "./store" { store, addTodo, toggleTodo }

def TodoList() -> any {
    dispatch = useDispatch();
    todos = useSelector(lambda state: any -> any { return state.todos.items; });
    [input, setInput] = useState("");

    addTodoAction = addTodo();

    def handleAdd() -> None {
        if input.trim() != "" {
            dispatch(addTodoAction(input));
            setInput("");
        }
    }

    return (
        <div>
            <input
                value={input}
                onChange={lambda e: any -> None { setInput(e.target.value); }}
            />
            <button onClick={handleAdd}>Add</button>
            <ul>
                {todos.map(lambda todo: any -> any {
                    return <li key={todo.id}>{todo.text}</li>;
                })}
            </ul>
        </div>
    );
}

def app() -> any {
    storeInstance = store();
    return (
        <Provider store={storeInstance}>
            <TodoList />
        </Provider>
    );
}
```

---

## 13. Authentication

JAC-Client provides built-in authentication functions.

### Available Functions

```jac
cl import from "@jac-client/utils" {
    jacSignup,      # (username, password) -> { success, error }
    jacLogin,       # (username, password) -> bool
    jacLogout,      # () -> void
    jacIsLoggedIn   # () -> bool
}
```

### Login Example

```jac
cl import from react { useState }
cl import from "@jac-client/utils" { jacLogin, jacIsLoggedIn }
cl import from react_router { useNavigate }

def LoginPage() -> any {
    [username, setUsername] = useState("");
    [password, setPassword] = useState("");
    [error, setError] = useState("");
    [loading, setLoading] = useState(False);
    navigate = useNavigate();

    async def handleLogin(e: any) -> None {
        e.preventDefault();
        setLoading(True);
        setError("");

        success = await jacLogin(username, password);

        setLoading(False);
        if success {
            navigate("/dashboard");
        } else {
            setError("Invalid username or password");
        }
    }

    # Redirect if already logged in
    if jacIsLoggedIn() {
        return <Navigate to="/dashboard" />;
    }

    return (
        <form onSubmit={handleLogin}>
            {error and <p style={{"color": "red"}}>{error}</p>}
            <input
                type="text"
                value={username}
                onChange={lambda e: any -> None { setUsername(e.target.value); }}
                placeholder="Username"
            />
            <input
                type="password"
                value={password}
                onChange={lambda e: any -> None { setPassword(e.target.value); }}
                placeholder="Password"
            />
            <button type="submit" disabled={loading}>
                {("Logging in...") if loading else ("Login")}
            </button>
        </form>
    );
}
```

### Signup Example

```jac
cl import from "@jac-client/utils" { jacSignup }

async def handleSignup(e: any) -> None {
    e.preventDefault();

    result = await jacSignup(username, password);

    if result["success"] {
        navigate("/login");
    } else {
        setError(result["error"]);
    }
}
```

### Logout

```jac
cl import from "@jac-client/utils" { jacLogout }
cl import from react_router { useNavigate }

def LogoutButton() -> any {
    navigate = useNavigate();

    def handleLogout() -> None {
        jacLogout();
        navigate("/login");
    }

    return <button onClick={handleLogout}>Logout</button>;
}
```

### Protected Route Pattern

```jac
cl import from "@jac-client/utils" { jacIsLoggedIn, Navigate }

def ProtectedRoute(children: any) -> any {
    if not jacIsLoggedIn() {
        return <Navigate to="/login" />;
    }
    return children;
}

# Usage
def app() -> any {
    return (
        <Router>
            <Routes>
                <Route path="/login" element={<LoginPage />} />
                <Route path="/dashboard" element={
                    <ProtectedRoute>
                        <Dashboard />
                    </ProtectedRoute>
                } />
            </Routes>
        </Router>
    );
}
```

---

## 14. Quick Reference Cheat Sheet

### Syntax At-a-Glance

| Category | React/JavaScript | JAC-Client |
|----------|-----------------|------------|
| **Variables** | `const x = 5` | `x = 5` |
| **State** | `const [x, setX] = useState(0)` | `[x, setX] = useState(0)` |
| **Functions** | `function fn() {}` | `def fn() -> any {}` |
| **Arrow (no params)** | `() => {}` | `lambda -> None {}` |
| **Arrow (params)** | `(a, b) => a + b` | `lambda a: int, b: int -> int { return a + b; }` |
| **Arrow (short)** | `() => doIt()` | `lambda: doIt()` |
| **Ternary** | `a ? b : c` | `(b) if a else (c)` |
| **AND** | `&&` | `and` |
| **OR** | `\|\|` | `or` |
| **NOT** | `!x` | `not x` |
| **Boolean** | `true`, `false` | `True`, `False` |
| **Null** | `null` | `None` |
| **Object** | `{ key: val }` | `{ "key": val }` |
| **Access** | `obj.key` | `obj["key"]` |
| **For loop** | `for(let i=0; i<5; i++)` | `for i=0 to i<5 by i+=1` |
| **For-of** | `for(x of arr)` | `for x in arr` |
| **Comments** | `// comment` | `# comment` |
| **Import** | `import { x } from 'y'` | `cl import from y { x }` |
| **Return null** | `return null` | `return <></>` |

### Common Patterns

**Event Handler:**
```jac
onClick={lambda: doSomething()}
onClick={lambda e: any -> None { e.preventDefault(); doSomething(); }}
```

**State Update:**
```jac
[count, setCount] = useState(0);
setCount(count + 1);
```

**Conditional Render:**
```jac
{isVisible and <Component />}
{(<Yes />) if condition else (<No />)}
```

**List Render:**
```jac
def renderItem(item: any, index: int) -> any {
    return <li key={index}>{item}</li>;
}
{items.map(renderItem)}
```

**Form Input:**
```jac
<input
    value={value}
    onChange={lambda e: any -> None { setValue(e.target.value); }}
/>
```

### Known Limitations

1. **No switch statement** - Use if-elif-else or object lookup pattern
2. **No nullish coalescing (`??`)** - Use `or` or explicit None check
3. **No range()** - Use `for i=0 to i<n by i+=1`
4. **Object keys must be strings** - `{"key": value}` not `{key: value}`
5. **Property access via brackets** - `obj["key"]` not `obj.key`

---

## Running Your First App

1. **Install JAC-Client:**
   ```bash
   pip install jac-client
   ```

2. **Create a new project:**
   ```bash
   jac create_jac_app my-app
   cd my-app
   ```

3. **Run the development server:**
   ```bash
   jac serve app.jac
   ```

4. **Open in browser:**
   Visit `http://localhost:8000`

---

Happy coding with JAC-Client!
