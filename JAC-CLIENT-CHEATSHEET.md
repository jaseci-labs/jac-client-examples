# JAC-Client Cheat Sheet

A quick reference guide for JavaScript developers. Print it, bookmark it, keep it handy!

---

## Table of Contents

1. [Variables & Constants](#1-variables--constants)
2. [Data Types](#2-data-types)
3. [Functions](#3-functions)
4. [Lambda (Arrow Functions)](#4-lambda-arrow-functions)
5. [State (useState)](#5-state-usestate)
6. [Effects (useEffect)](#6-effects-useeffect)
7. [Other Hooks](#7-other-hooks)
8. [Event Handling](#8-event-handling)
9. [Conditional Rendering](#9-conditional-rendering)
10. [Loops](#10-loops)
11. [Array Methods](#11-array-methods)
12. [Objects/Dictionaries](#12-objectsdictionaries)
13. [Components](#13-components)
14. [Props](#14-props)
15. [Imports](#15-imports)
16. [JSX](#16-jsx)
17. [Styling](#17-styling)
18. [Routing](#18-routing)
19. [Forms](#19-forms)
20. [Async/Await](#20-asyncawait)
21. [Common Gotchas](#21-common-gotchas)

---

## 1. Variables & Constants

| React                   | JAC-Client         |
| ----------------------- | ------------------ |
| `const name = "John"`   | `name = "John"`    |
| `let count = 0`         | `count = 0`        |
| `const arr = [1, 2, 3]` | `arr = [1, 2, 3]`  |
| `const obj = { a: 1 }`  | `obj = { "a": 1 }` |

```jac
# JAC-Client - No let/const needed
name = "John"
count = 0
items = ["a", "b", "c"]
user = { "name": "John", "age": 25 }
```

---

## 2. Data Types

| Type          | React          | JAC-Client       |
| ------------- | -------------- | ---------------- |
| Boolean true  | `true`         | `True`           |
| Boolean false | `false`        | `False`          |
| Null          | `null`         | `None`           |
| Undefined     | `undefined`    | `None`           |
| String        | `"hello"`      | `"hello"`        |
| Number        | `42`           | `42`             |
| Array         | `[1, 2, 3]`    | `[1, 2, 3]`      |
| Object        | `{ key: val }` | `{ "key": val }` |

```jac
# Booleans - Capitalized!
isActive = True
isHidden = False

# Null - Use None
data = None
user = None

# Check for None
if data == None {
    console.log("No data");
}
```

---

## 3. Functions

| Pattern        | React                   | JAC-Client                          |
| -------------- | ----------------------- | ----------------------------------- |
| Basic function | `function greet() {}`   | `def greet() -> any {}`             |
| With params    | `function add(a, b) {}` | `def add(a: int, b: int) -> int {}` |
| Return value   | `return x + y`          | `return x + y;`                     |
| No return      | `function log() {}`     | `def log() -> None {}`              |

```jac
# Basic function
def greet() -> any {
    return "Hello!";
}

# With parameters and types
def add(a: int, b: int) -> int {
    return a + b;
}

# No return value
def logMessage(msg: str) -> None {
    console.log(msg);
}

# Function with default parameter
def greetUser(name: str = "Guest") -> str {
    return "Hello, " + name;
}
```

---

## 4. Lambda (Arrow Functions)

This is the **BIGGEST** syntax change!

### Quick Reference

| Pattern           | React          | JAC-Client                               |
| ----------------- | -------------- | ---------------------------------------- |
| No params         | `() => {}`     | `lambda -> None {}`                      |
| No params (short) | `() => doIt()` | `lambda: doIt()`                         |
| One param         | `(x) => {}`    | `lambda x: any -> None {}`               |
| Two params        | `(a, b) => {}` | `lambda a: any, b: any -> None {}`       |
| With return       | `(x) => x * 2` | `lambda x: int -> int { return x * 2; }` |
| Event handler     | `(e) => {}`    | `lambda e: any -> None {}`               |

### Examples

```jac
# No parameters - short form (single expression)
onClick={lambda: setCount(count + 1)}
onClick={lambda: console.log("clicked")}

# No parameters - full form (multiple statements)
onClick={lambda -> None {
    setCount(count + 1);
    console.log("clicked");
}}

# One parameter
onChange={lambda e: any -> None { setName(e.target.value); }}

# Two parameters
onCalculate={lambda a: int, b: int -> None { setResult(a + b); }}

# With return value (for map/filter)
doubled = numbers.map(lambda x: int, i: int -> int { return x * 2; })

# Helper function style (recommended for complex logic)
def handleClick(e: any) -> None {
    e.preventDefault();
    doSomething();
}
```

---

## 5. State (useState)

| Pattern | React                                    | JAC-Client                         |
| ------- | ---------------------------------------- | ---------------------------------- |
| Basic   | `const [x, setX] = useState(0)`          | `[x, setX] = useState(0)`          |
| String  | `const [name, setName] = useState("")`   | `[name, setName] = useState("")`   |
| Boolean | `const [on, setOn] = useState(false)`    | `[on, setOn] = useState(False)`    |
| Array   | `const [items, setItems] = useState([])` | `[items, setItems] = useState([])` |
| Object  | `const [user, setUser] = useState({})`   | `[user, setUser] = useState({})`   |

```jac
# Import
cl import from react { useState }

# Basic state
[count, setCount] = useState(0);
[name, setName] = useState("");
[isOpen, setIsOpen] = useState(False);
[items, setItems] = useState([]);
[user, setUser] = useState({ "name": "", "age": 0 });

# Update state
setCount(count + 1);
setName("John");
setIsOpen(True);
setItems(items.concat(["new item"]));
setUser({ "name": "John", "age": 25 });
```

---

## 6. Effects (useEffect)

| Pattern      | React                                      | JAC-Client                                                    |
| ------------ | ------------------------------------------ | ------------------------------------------------------------- |
| On mount     | `useEffect(() => {}, [])`                  | `useEffect(lambda -> None {}, [])`                            |
| On change    | `useEffect(() => {}, [dep])`               | `useEffect(lambda -> None {}, [dep])`                         |
| With cleanup | `useEffect(() => { return () => {} }, [])` | `useEffect(lambda -> None { return lambda -> None {}; }, [])` |

```jac
cl import from react { useEffect }

# Run on mount (empty dependency array)
useEffect(lambda -> None {
    console.log("Component mounted");
}, []);

# Run when dependency changes
useEffect(lambda -> None {
    console.log("Count changed:", count);
}, [count]);

# With cleanup function
useEffect(lambda -> None {
    timer = setInterval(lambda -> None { tick(); }, 1000);
    return lambda -> None {
        clearInterval(timer);
    };
}, []);

# Multiple dependencies
useEffect(lambda -> None {
    fetchData(userId, filter);
}, [userId, filter]);
```

---

## 7. Other Hooks

### useCallback

| React                           | JAC-Client                               |
| ------------------------------- | ---------------------------------------- |
| `useCallback(() => {}, [deps])` | `useCallback(lambda -> None {}, [deps])` |

```jac
cl import from react { useCallback }

handleClick = useCallback(
    lambda -> None { setCount(count + 1); },
    [count]
);
```

### useMemo

| React                          | JAC-Client                                         |
| ------------------------------ | -------------------------------------------------- |
| `useMemo(() => value, [deps])` | `useMemo(lambda -> any { return value; }, [deps])` |

```jac
cl import from react { useMemo }

expensiveValue = useMemo(
    lambda -> int { return count * 100; },
    [count]
);
```

### useRef

| React          | JAC-Client     |
| -------------- | -------------- |
| `useRef(null)` | `useRef(None)` |

```jac
cl import from react { useRef }

inputRef = useRef(None);
# Usage: inputRef.current.focus();
```

---

## 8. Event Handling

### Common Events

| Event     | React                   | JAC-Client                             |
| --------- | ----------------------- | -------------------------------------- |
| Click     | `onClick={() => {}}`    | `onClick={lambda: fn()}`               |
| Change    | `onChange={(e) => {}}`  | `onChange={lambda e: any -> None {}}`  |
| Submit    | `onSubmit={(e) => {}}`  | `onSubmit={lambda e: any -> None {}}`  |
| Focus     | `onFocus={() => {}}`    | `onFocus={lambda: fn()}`               |
| Blur      | `onBlur={() => {}}`     | `onBlur={lambda: fn()}`                |
| Key press | `onKeyDown={(e) => {}}` | `onKeyDown={lambda e: any -> None {}}` |

### Examples

```jac
# Simple click
<button onClick={lambda: setCount(count + 1)}>Click</button>

# Click with multiple actions
<button onClick={lambda -> None {
    setCount(count + 1);
    setMessage("Clicked!");
}}>Click</button>

# Input change
<input onChange={lambda e: any -> None { setName(e.target.value); }} />

# Form submit
<form onSubmit={lambda e: any -> None {
    e.preventDefault();
    handleSubmit();
}}>

# Pass parameters
<button onClick={lambda: handleSelect(item["id"], item["name"])}>
    Select
</button>

# Keyboard events
<input onKeyDown={lambda e: any -> None {
    if e.key == "Enter" {
        submit();
    }
}} />
```

---

## 9. Conditional Rendering

### Ternary (Python Style!)

| React               | JAC-Client                  |
| ------------------- | --------------------------- |
| `condition ? a : b` | `(a) if condition else (b)` |

```jac
# Simple ternary
{("Yes") if isActive else ("No")}

# JSX ternary - WRAP IN PARENTHESES!
{(<LoggedIn />) if isLoggedIn else (<LoggedOut />)}

# Nested ternary
{("A") if x > 10 else (("B") if x > 5 else ("C"))}
```

### Logical Operators

| Operator | React  | JAC-Client   |
| -------- | ------ | ------------ |
| AND      | `&&`   | `and`, `&&`  |
| OR       | `\|\|` | `or`, `\|\|` |
| NOT      | `!`    | `not`        |

```jac
# AND - Show if true
{isLoggedIn and <Dashboard />}
{count > 0 and <p>Count: {count}</p>}

# OR - Default value
{username or "Guest"}
{data or "Loading..."}

# NOT
{not isLoading and <Content />}
{not error and <Success />}

# Combined
{isLoggedIn and not isAdmin and <UserDashboard />}
```

### If-Else in Functions

```jac
def Status(props: dict) -> any {
    if props["status"] == "loading" {
        return <p>Loading...</p>;
    }
    if props["status"] == "error" {
        return <p>Error!</p>;
    }
    return <p>Success!</p>;
}
```

### Return Nothing

| React         | JAC-Client     |
| ------------- | -------------- |
| `return null` | `return <></>` |

```jac
if not shouldShow {
    return <></>;  # Empty fragment
}
```

---

## 10. Loops

### For Loop (Counter-based)

| React                    | JAC-Client               |
| ------------------------ | ------------------------ |
| `for(let i=0; i<5; i++)` | `for i=0 to i<5 by i+=1` |

```jac
# Basic loop (0 to 4)
for i=0 to i<5 by i+=1 {
    console.log(i);
}

# Inclusive (1 to 5)
for i=1 to i<=5 by i+=1 {
    console.log(i);
}

# Step by 2
for i=0 to i<=10 by i+=2 {
    console.log(i);  # 0, 2, 4, 6, 8, 10
}

# Countdown
for i=5 to i>=0 by i-=1 {
    console.log(i);  # 5, 4, 3, 2, 1, 0
}
```

### For-In Loop (Iterate Array)

| React                | JAC-Client          |
| -------------------- | ------------------- |
| `for(item of items)` | `for item in items` |

```jac
fruits = ["apple", "banana", "cherry"];

for fruit in fruits {
    console.log(fruit);
}

# Sum numbers
total = 0;
for num in numbers {
    total = total + num;
}
```

### While Loop

| React              | JAC-Client        |
| ------------------ | ----------------- |
| `while(condition)` | `while condition` |

```jac
count = 0;
while count < 5 {
    console.log(count);
    count = count + 1;
}
```

---

## 11. Array Methods

### map

| React                 | JAC-Client                                                |
| --------------------- | --------------------------------------------------------- |
| `arr.map(x => x * 2)` | `arr.map(lambda x: int, i: int -> int { return x * 2; })` |

```jac
# With helper function (recommended)
def double(n: int, index: int) -> int {
    return n * 2;
}
doubled = numbers.map(double);

# Inline lambda
doubled = numbers.map(lambda n: int, i: int -> int { return n * 2; });

# Render list
def renderItem(item: str, index: int) -> any {
    return <li key={index}>{item}</li>;
}
<ul>{items.map(renderItem)}</ul>
```

### filter

| React                    | JAC-Client                                            |
| ------------------------ | ----------------------------------------------------- |
| `arr.filter(x => x > 0)` | `arr.filter(lambda x: int -> bool { return x > 0; })` |

```jac
evens = numbers.filter(lambda n: int -> bool { return n % 2 == 0; });

activeUsers = users.filter(lambda u: dict -> bool { return u["active"]; });
```

### find

| React                       | JAC-Client                                                  |
| --------------------------- | ----------------------------------------------------------- |
| `arr.find(x => x.id === 1)` | `arr.find(lambda x: dict -> bool { return x["id"] == 1; })` |

```jac
user = users.find(lambda u: dict -> bool { return u["id"] == searchId; });
```

### some & every

```jac
# some - at least one matches
hasAdults = users.some(lambda u: dict -> bool { return u["age"] >= 18; });

# every - all match
allAdults = users.every(lambda u: dict -> bool { return u["age"] >= 18; });
```

### reduce

| React                                | JAC-Client                                                          |
| ------------------------------------ | ------------------------------------------------------------------- |
| `arr.reduce((acc, x) => acc + x, 0)` | `arr.reduce(lambda acc: int, x: int -> int { return acc + x; }, 0)` |

```jac
total = prices.reduce(lambda acc: float, price: float -> float {
    return acc + price;
}, 0);
```

### sort

```jac
# Ascending
sorted = items.slice().sort(lambda a: int, b: int -> int { return a - b; });

# Descending
sorted = items.slice().sort(lambda a: int, b: int -> int { return b - a; });
```

### Other Methods

```jac
# concat (add items)
newItems = items.concat(["new item"]);
newItems = items.concat([item1, item2]);

# slice
first3 = items.slice(0, 3);
last2 = items.slice(-2);

# includes
hasApple = fruits.includes("apple");

# indexOf
index = fruits.indexOf("banana");

# join
str = items.join(", ");

# spread (copy)
copy = [*original];
merged = [*arr1, *arr2];
```

---

## 12. Objects/Dictionaries

### Syntax

| Pattern | React            | JAC-Client         |
| ------- | ---------------- | ------------------ |
| Create  | `{ key: value }` | `{ "key": value }` |
| Access  | `obj.key`        | `obj["key"]`       |
| Access  | `obj["key"]`     | `obj["key"]`       |
| Spread  | `{...obj}`       | `{**obj}`          |

```jac
# Create - keys MUST be quoted strings
user = { "name": "John", "age": 25 };
style = { "padding": "10px", "margin": "5px" };

# Access - use bracket notation
name = user["name"];
age = user["age"];

# Update (create new object)
updatedUser = { "name": user["name"], "age": 26 };

# Spread
copy = {**original};
merged = {**obj1, **obj2};
updated = {**user, "age": 26};

# Check if key exists
if "name" in user {
    console.log(user["name"]);
}
```

---

## 13. Components

### Basic Component

```jac
def Greeting() -> any {
    return <h1>Hello, World!</h1>;
}
```

### Component with State

```jac
def Counter() -> any {
    [count, setCount] = useState(0);

    return (
        <div>
            <p>Count: {count}</p>
            <button onClick={lambda: setCount(count + 1)}>+</button>
        </div>
    );
}
```

### Entry Point (app)

```jac
# app() is the main entry point (like App in React)
def app() -> any {
    return (
        <div>
            <Header />
            <Content />
            <Footer />
        </div>
    );
}
```

---

## 14. Props

### Passing Props

```jac
<UserCard name="John" age={25} isActive={True} />
<Button onClick={lambda: handleClick()} disabled={False} />
```

### Receiving Props

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
```

### Props with Children

```jac
def Container(props: dict) -> any {
    return (
        <div className="container">
            {props["children"]}
        </div>
    );
}

# Usage
<Container>
    <p>Content inside</p>
</Container>
```

---

## 15. Imports

### Syntax

| React                        | JAC-Client                    |
| ---------------------------- | ----------------------------- |
| `import { x } from 'lib'`    | `cl import from lib { x }`    |
| `import { x, y } from 'lib'` | `cl import from lib { x, y }` |
| `import './style.css'`       | `cl import "./style.css"`     |

### Examples

```jac
# React hooks
cl import from react { useState, useEffect, useCallback, useMemo, useRef }

# Router
cl import from react_router { Router, Routes, Route, Link, useNavigate, useParams }

# Third-party libraries
cl import from zustand { create }
cl import from "react-redux" { Provider, useSelector, useDispatch }
cl import from "@reduxjs/toolkit" { createSlice, configureStore }
cl import from "react-hook-form" { useForm }
cl import from zod { z }

# Local imports
cl import from "./store" { useCounterStore }
cl import from "./components" { Header, Footer }

# CSS
cl import "./styles.css"
cl import "./global.css"
```

---

## 16. JSX

### Basics

```jac
# Same as React JSX
<div className="container">
    <h1>Title</h1>
    <p>Paragraph</p>
</div>

# Self-closing tags
<input />
<br />
<img src="image.jpg" alt="description" />

# Expressions in JSX
<p>Count: {count}</p>
<p>Name: {user["name"]}</p>
<p>Total: {price * quantity}</p>

# Conditional class
<div className={("active") if isActive else ("inactive")}>

# Multiple classes
<div className={"base-class " + (("active") if isActive else (""))}>
```

### Fragments

```jac
# Empty fragment
return <></>;

# Fragment with children
return (
    <>
        <Header />
        <Content />
    </>
);
```

---

## 17. Styling

### Inline Styles

```jac
# Keys must be quoted strings!
<div style={{ "padding": "10px", "backgroundColor": "#f0f0f0" }}>

# Dynamic styles
<button style={{
    "backgroundColor": ("green") if isActive else ("gray"),
    "color": "white",
    "padding": "10px"
}}>

# Style object
styles = {
    "container": { "padding": "20px", "margin": "10px" },
    "title": { "fontSize": "24px", "fontWeight": "bold" }
};

<div style={styles["container"]}>
    <h1 style={styles["title"]}>Title</h1>
</div>
```

### Tailwind CSS

```jac
cl import "./global.css"  # Contains @import "tailwindcss"

<button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
    Click Me
</button>

# Dynamic classes
<div className={"p-4 " + (("bg-green-500") if isSuccess else ("bg-red-500"))}>
```

### CSS Classes

```jac
<div className="container">
<div className="btn btn-primary">
<div className={("active") if isActive else ("")}>
```

---

## 18. Routing

### Setup

```jac
cl import from react_router { Router, Routes, Route, Link, useNavigate, useParams, useLocation }
```

### Basic Routes

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
                <Route path="/user/:id" element={<UserProfile />} />
                <Route path="*" element={<NotFound />} />
            </Routes>
        </Router>
    );
}
```

### Navigation Hooks

```jac
# useNavigate - programmatic navigation
navigate = useNavigate();
navigate("/dashboard");
navigate(-1);  # Go back

# useParams - URL parameters
params = useParams();
userId = params.id;

# useLocation - current location
location = useLocation();
currentPath = location.pathname;
```

---

## 19. Forms

### Controlled Input

```jac
[name, setName] = useState("");

<input
    value={name}
    onChange={lambda e: any -> None { setName(e.target.value); }}
    placeholder="Enter name"
/>
```

### Form Submit

```jac
def handleSubmit(e: any) -> None {
    e.preventDefault();
    console.log("Submitted:", name, email);
}

<form onSubmit={handleSubmit}>
    <input value={name} onChange={lambda e: any -> None { setName(e.target.value); }} />
    <input value={email} onChange={lambda e: any -> None { setEmail(e.target.value); }} />
    <button type="submit">Submit</button>
</form>
```

### Checkbox

```jac
[checked, setChecked] = useState(False);

<input
    type="checkbox"
    checked={checked}
    onChange={lambda -> None { setChecked(not checked); }}
/>
```

### Select

```jac
[selected, setSelected] = useState("");

<select value={selected} onChange={lambda e: any -> None { setSelected(e.target.value); }}>
    <option value="">Select...</option>
    <option value="a">Option A</option>
    <option value="b">Option B</option>
</select>
```

---

## 20. Async/Await

```jac
# Async function
async def fetchData() -> None {
    setLoading(True);
    try {
        response = await fetch("/api/data");
        data = await response.json();
        setData(data);
    } catch {
        setError("Failed to fetch");
    } finally {
        setLoading(False);
    }
}

# Call async function
<button onClick={lambda: fetchData()}>Load Data</button>

# In useEffect
useEffect(lambda -> None {
    fetchData();
}, []);
```

---

## 21. Common Gotchas

### 1. Object Keys Must Be Strings

```jac
# WRONG
style = { padding: "10px" }

# CORRECT
style = { "padding": "10px" }
```

### 2. Access Object Properties with Brackets

```jac
# Works
user.name

# Recommended
user["name"]
```

### 3. Booleans are Capitalized

```jac
# Works
isActive = true

# Recommended
isActive = True
```

### 4. Null is None

```jac
# WRONG
data = null

# CORRECT
data = None
```

### 5. Wrap JSX in Ternary with Parentheses

```jac
# WRONG
{<Yes /> if condition else <No />}

# CORRECT
{(<Yes />) if condition else (<No />)}
```

### 6. No range() Function

```jac
# WRONG
for i in range(5) { }

# CORRECT
for i=0 to i<5 by i+=1 { }
```

### 7. Lambda Return Type Required

```jac
# WRONG
onClick={lambda { doIt(); }}

# CORRECT
onClick={lambda -> None { doIt(); }}
# OR short form
onClick={lambda: doIt()}
```

### 8. Comments Use

```jac
# WRONG
// This is a comment

# CORRECT
# This is a comment
```

### 9. No switch Statement

```jac
# Use if-elif-else instead
if status == "loading" {
    return <Loading />;
} elif status == "error" {
    return <Error />;
} else {
    return <Success />;
}

# Or object lookup
messages = {
    "loading": "Please wait...",
    "error": "Something went wrong",
    "success": "Done!"
};
message = messages[status] if status in messages else "Unknown";
```

### 10. No Nullish Coalescing (??)

```jac
# WRONG
value = data ?? "default"

# CORRECT
value = data or "default"
# Or explicit check
value = data if data != None else "default"
```

---

## Quick Syntax Reference

| Category       | React                           | JAC-Client                         |
| -------------- | ------------------------------- | ---------------------------------- |
| Variable       | `const x = 5`                   | `x = 5`                            |
| State          | `const [x, setX] = useState(0)` | `[x, setX] = useState(0)`          |
| Function       | `function fn() {}`              | `def fn() -> any {}`               |
| Arrow (none)   | `() => {}`                      | `lambda -> None {}`                |
| Arrow (short)  | `() => doIt()`                  | `lambda: doIt()`                   |
| Arrow (params) | `(a, b) => {}`                  | `lambda a: any, b: any -> None {}` |
| Ternary        | `a ? b : c`                     | `(b) if a else (c)`                |
| AND            | `&&`                            | `and`                              |
| OR             | `\|\|`                          | `or`                               |
| NOT            | `!x`                            | `not x`                            |
| True           | `true`                          | `True`                             |
| False          | `false`                         | `False`                            |
| Null           | `null`                          | `None`                             |
| Object         | `{ key: val }`                  | `{ "key": val }`                   |
| Access         | `obj.key`                       | `obj["key"]`                       |
| Spread         | `{...obj}`                      | `{**obj}`                          |
| For            | `for(let i=0; i<5; i++)`        | `for i=0 to i<5 by i+=1`           |
| For-of         | `for(x of arr)`                 | `for x in arr`                     |
| Comment        | `// text`                       | `# text`                           |
| Import         | `import { x } from 'lib'`       | `cl import from lib { x }`         |
| Return null    | `return null`                   | `return <></>`                     |

---

Happy coding with JAC-Client!
