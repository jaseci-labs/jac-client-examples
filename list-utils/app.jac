
# ============================================
# LIST HANDLING IN JAC-LANG (ONELANG)
# Practical examples for arrays/lists
# ============================================

cl import from react {useState}

cl {
    let styles = {
        "container": { "fontFamily": "Arial, sans-serif", "maxWidth": "900px", "margin": "0 auto", "padding": "20px" },
        "section": { "marginBottom": "25px", "padding": "20px", "backgroundColor": "#f8f9fa", "borderRadius": "8px", "border": "1px solid #dee2e6" },
        "title": { "color": "#333", "borderLeft": "4px solid #007bff", "paddingLeft": "10px", "marginBottom": "15px" },
        "code": { "backgroundColor": "#2d2d2d", "color": "#f8f8f2", "padding": "15px", "borderRadius": "5px", "fontFamily": "monospace", "fontSize": "13px", "marginBottom": "15px", "whiteSpace": "pre-wrap" },
        "button": { "padding": "8px 16px", "marginRight": "8px", "marginBottom": "8px", "backgroundColor": "#007bff", "color": "white", "border": "none", "borderRadius": "5px", "cursor": "pointer" },
        "result": { "padding": "15px", "backgroundColor": "#e8f5e9", "borderRadius": "5px", "marginTop": "10px" },
        "item": { "padding": "8px 12px", "margin": "4px", "backgroundColor": "#007bff", "color": "white", "borderRadius": "4px", "display": "inline-block" }
    };

    # ============================================
    # Example 1: INLINE MAP - Render Lists
    # ============================================
    def Example1_InlineMap() -> any {
        let fruits = ["Apple", "Banana", "Cherry", "Date"];
        let numbers = [1, 2, 3, 4, 5];

        let codeText = "# Inline map in JSX\n<ul>\n    {items.map(lambda item: str, i: int -> any {\n        return <li key={i}>{item}</li>;\n    })}\n</ul>";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>1. Inline Map - Render Lists</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <strong>Fruits:</strong>
                <ul>
                    {fruits.map(lambda item: str, i: int -> any {
                        return <li key={i}>🍎 {item}</li>;
                    })}
                </ul>
                
                <strong>Numbers doubled:</strong>
                <div>
                    {numbers.map(lambda n: int, i: int -> any {
                        return <span key={i} style={styles["item"]}>{n * 2}</span>;
                    })}
                </div>
            </div>
        );
    }

    # ============================================
    # Example 2: FILTER - Remove Items
    # ============================================
    def Example2_Filter() -> any {
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        let [items, setItems] = useState(array);



        def showEven() -> None {
            setItems(array.filter(lambda n: int -> bool { return n % 2 == 0; }));
        }

        def showOdd() -> None {
            setItems(array.filter(lambda n: int -> bool { return n % 2 != 0; }));
        }

        def showAll() -> None {
            setItems(array);
        }

        let codeText = "# Filter array\nlet evens = numbers.filter(lambda n: int -> bool {\n    return n % 2 == 0;\n});\n# Result: [2, 4, 6, 8, 10]";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>2. Filter - Remove Items</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={showAll}>All</button>
                <button style={styles["button"]} onClick={showEven}>Even Only</button>
                <button style={styles["button"]} onClick={showOdd}>Odd Only</button>
                
                <div style={styles["result"]}>
                    {items.map(lambda n: int, i: int -> any {
                        return <span key={i} style={styles["item"]}>{n}</span>;
                    })}
                </div>
            </div>
        );
    }

    # ============================================
    # Example 3: FIND & SOME & EVERY
    # ============================================
    def Example3_FindSomeEvery() -> any {
        let users = [
            { "name": "Alice", "age": 25 },
            { "name": "Bob", "age": 17 },
            { "name": "Charlie", "age": 30 }
        ];

        let codeText = "# Find first match\nlet adult = users.find(lambda u -> bool { return u['age'] >= 18; });\n\n# Check if any match\nlet hasMinor = users.some(lambda u -> bool { return u['age'] < 18; });\n\n# Check if all match\nlet allAdults = users.every(lambda u -> bool { return u['age'] >= 18; });";

        let firstAdult = users.find(lambda u: dict -> bool { return u["age"] >= 18; });
        let hasMinor = users.some(lambda u: dict -> bool { return u["age"] < 18; });
        let allAdults = users.every(lambda u: dict -> bool { return u["age"] >= 18; });

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>3. Find, Some, Every</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={styles["result"]}>
                    <p><strong>Users:</strong> {JSON.stringify(users)}</p>
                    <p>✅ First adult: {firstAdult["name"]} (age {firstAdult["age"]})</p>
                    <p>✅ Has minor? {hasMinor.toString()}</p>
                    <p>✅ All adults? {allAdults.toString()}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 4: REDUCE - Aggregate Values
    # ============================================
    def Example4_Reduce() -> any {
        let prices = [29.99, 9.99, 49.99, 19.99];

        let codeText = "# Sum all values\nlet total = prices.reduce(lambda acc: float, price: float -> float {\n    return acc + price;\n}, 0);\n# Result: 109.96";

        let total = prices.reduce(lambda acc: float, price: float -> float {
            return acc + price;
        }, 0);

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>4. Reduce - Sum/Aggregate</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={styles["result"]}>
                    <p><strong>Prices:</strong> {prices.map(lambda p: float, i: int -> any {
                        return <span key={i} style={styles["item"]}>${p}</span>;
                    })}</p>
                    <p><strong>Total:</strong> ${total.toFixed(2)}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 5: CHAINING - Map + Filter
    # ============================================
    def Example5_Chaining() -> any {
        let products = [
            { "name": "Laptop", "price": 999, "inStock": True },
            { "name": "Mouse", "price": 29, "inStock": True },
            { "name": "Keyboard", "price": 79, "inStock": False },
            { "name": "Monitor", "price": 299, "inStock": True }
        ];

        let codeText = "# Chain filter + map\nlet availableNames = products\n    .filter(lambda p -> bool { return p['inStock']; })\n    .map(lambda p -> str { return p['name']; });";

        let available = products.filter(lambda p: dict -> bool { return p["inStock"]; });
        let names = available.map(lambda p: dict -> str { return p["name"]; });

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>5. Chaining - Filter + Map</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={styles["result"]}>
                    <p><strong>All products:</strong> {products.length}</p>
                    <p><strong>In stock:</strong> {names.map(lambda n: str, i: int -> any {
                        return <span key={i} style={styles["item"]}>{n}</span>;
                    })}</p>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 6: ADD/REMOVE Items (State)
    # ============================================
    def Example6_AddRemove() -> any {
        let [todos, setTodos] = useState(["Learn JAC", "Build App"]);
        let [input, setInput] = useState("");

        def addItem() -> None {
            if input.length > 0 {
                setTodos(todos.concat([input]));
                setInput("");
            }
        }

        def removeItem(index: int) -> None {
            setTodos(todos.filter(lambda item: str, i: int -> bool { return i != index; }));
        }

        let codeText = "# Add item\nsetTodos(todos.concat([newItem]));\n\n# Remove by index\nsetTodos(todos.filter(lambda item, i -> bool {\n    return i != indexToRemove;\n}));";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>6. Add/Remove Items</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <input 
                    value={input} 
                    onChange={lambda e: any -> None { setInput(e.target.value); }}
                    placeholder="New todo..."
                    style={{ "padding": "8px", "marginRight": "8px" }}
                />
                <button style={styles["button"]} onClick={addItem}>Add</button>
                
                <ul>
                    {todos.map(lambda item: str, i: int -> any {
                        return (
                            <li key={i}>
                                {item} 
                                <button onClick={lambda: removeItem(i)} style={{ "marginLeft": "10px", "color": "red", "cursor": "pointer" }}>✕</button>
                            </li>
                        );
                    })}
                </ul>
            </div>
        );
    }

    # ============================================
    # Example 7: SORT Lists
    # ============================================
    def Example7_Sort() -> any {
        let [items, setItems] = useState([42, 8, 15, 23, 4, 16]);

        def sortAsc() -> None {
            let sorted = items.slice().sort(lambda a: int, b: int -> int { return a - b; });
            setItems(sorted);
        }

        def sortDesc() -> None {
            let sorted = items.slice().sort(lambda a: int, b: int -> int { return b - a; });
            setItems(sorted);
        }

        def shuffle() -> None {
            setItems([42, 8, 15, 23, 4, 16]);
        }

        let codeText = "# Sort ascending\nitems.sort(lambda a, b -> int { return a - b; });\n\n# Sort descending\nitems.sort(lambda a, b -> int { return b - a; });";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>7. Sort Lists</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={sortAsc}>Sort ↑</button>
                <button style={styles["button"]} onClick={sortDesc}>Sort ↓</button>
                <button style={styles["button"]} onClick={shuffle}>Reset</button>
                
                <div style={styles["result"]}>
                    {items.map(lambda n: int, i: int -> any {
                        return <span key={i} style={styles["item"]}>{n}</span>;
                    })}
                </div>
            </div>
        );
    }

    # ============================================
    # Example 8: SPREAD & SLICE
    # ============================================
    def Example8_SpreadSlice() -> any {
        let original = [1, 2, 3, 4, 5];

        let copied = [*original];
        let first3 = original.slice(0, 3);
        let last2 = original.slice(-2);
        let middle = original.slice(1, 4);
        let merged = [*original, *[6, 7, 8]];

        let codeText = "# Copy array\nlet copy = [*original];\n\n# Slice (start, end)\nlet first3 = arr.slice(0, 3);  # [1,2,3]\nlet last2 = arr.slice(-2);     # [4,5]\n\n# Merge arrays\nlet merged = [*arr1, *arr2];";

        def renderArr(arr: list, label: str) -> any {
            return (
                <p><strong>{label}:</strong> [{arr.join(", ")}]</p>
            );
        }

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>8. Spread & Slice</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={styles["result"]}>
                    {renderArr(original, "Original")}
                    {renderArr(copied, "Copied [*arr]")}
                    {renderArr(first3, "First 3 slice(0,3)")}
                    {renderArr(last2, "Last 2 slice(-2)")}
                    {renderArr(middle, "Middle slice(1,4)")}
                    {renderArr(merged, "Merged")}
                </div>
            </div>
        );
    }

    # ============================================
    # Example 9: INCLUDES & INDEXOF
    # ============================================
    def Example9_SearchMethods() -> any {
        let colors = ["red", "green", "blue", "yellow"];

        let codeText = "# Check if exists\nlet hasRed = colors.includes('red');  # True\n\n# Find index\nlet idx = colors.indexOf('blue');  # 2\nlet notFound = colors.indexOf('pink');  # -1";

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>9. Includes & IndexOf</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <div style={styles["result"]}>
                    <p><strong>Colors:</strong> {JSON.stringify(colors)}</p>
                    <p>includes(red): <strong>{colors.includes("red").toString()}</strong></p>
                    <p>includes(pink): <strong>{colors.includes("pink").toString()}</strong></p>
                    <p>indexOf(blue): <strong>{colors.indexOf("blue")}</strong></p>
                    <p>indexOf(pink): <strong>{colors.indexOf("pink")}</strong> (not found)</p>
                </div>
            </div>
        );
    }

    # ============================================
    # Example 10: REAL-WORLD - Todo Filter
    # ============================================
    def Example10_RealWorld() -> any {
        let [filter, setFilter] = useState("all");
        let tasks = [
            { "id": 1, "text": "Learn JAC", "done": True },
            { "id": 2, "text": "Build project", "done": False },
            { "id": 3, "text": "Write tests", "done": False },
            { "id": 4, "text": "Deploy app", "done": True }
        ];

        def getFiltered() -> list {
            if filter == "done" {
                return tasks.filter(lambda t: dict -> bool { return t["done"]; });
            }
            if filter == "pending" {
                return tasks.filter(lambda t: dict -> bool { return not t["done"]; });
            }
            return tasks;
        }

        let codeText = "# Filter by status\nlet pending = tasks.filter(lambda t -> bool {\n    return not t['done'];\n});\n\n# Count completed\nlet doneCount = tasks.filter(t => t['done']).length;";

        let filtered = getFiltered();
        let doneCount = tasks.filter(lambda t: dict -> bool { return t["done"]; }).length;

        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>10. Real-World: Todo Filter</h3>
                <pre style={styles["code"]}>{codeText}</pre>
                
                <button style={styles["button"]} onClick={lambda: setFilter("all")}>All ({tasks.length})</button>
                <button style={styles["button"]} onClick={lambda: setFilter("done")}>Done ({doneCount})</button>
                <button style={styles["button"]} onClick={lambda: setFilter("pending")}>Pending ({tasks.length - doneCount})</button>
                
                <ul>
                    {filtered.map(lambda t: dict -> any {
                        return (
                            <li key={t["id"]} style={{ "textDecoration": (("line-through") if t["done"] else ("none")) }}>
                                {(("✅") if t["done"] else ("⬜"))} {t["text"]}
                            </li>
                        );
                    })}
                </ul>
            </div>
        );
    }

    # ============================================
    # QUICK REFERENCE
    # ============================================
    def QuickReference() -> any {
        return (
            <div style={styles["section"]}>
                <h3 style={styles["title"]}>📋 Quick Reference</h3>
                <table style={{ "width": "100%", "borderCollapse": "collapse" }}>
                    <thead>
                        <tr style={{ "backgroundColor": "#333", "color": "white" }}>
                            <th style={{ "padding": "10px", "textAlign": "left" }}>Method</th>
                            <th style={{ "padding": "10px", "textAlign": "left" }}>Purpose</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.map()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Transform each item</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.filter()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Keep items that match</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.find()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Get first match</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.some()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Check if any match</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.every()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Check if all match</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.reduce()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Aggregate to single value</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.sort()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Sort items</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.concat()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Add items (immutable)</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.slice()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Get portion of array</td></tr>
                        <tr><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>.includes()</td><td style={{ "padding": "8px", "border": "1px solid #ddd" }}>Check if contains</td></tr>
                    </tbody>
                </table>
            </div>
        );
    }

    # ============================================
    # MAIN APP
    # ============================================
    def app() -> any {
        return (
            <div style={styles["container"]}>
                <h1 style={{ "textAlign": "center", "color": "#333" }}>📋 List Handling in JAC-Lang</h1>
                <p style={{ "textAlign": "center", "color": "#666", "marginBottom": "30px" }}>
                    Practical array methods with inline lambdas
                </p>
                
                <QuickReference />
                <Example1_InlineMap />
                <Example2_Filter />
                <Example3_FindSomeEvery />
                <Example4_Reduce />
                <Example5_Chaining />
                <Example6_AddRemove />
                <Example7_Sort />
                <Example8_SpreadSlice />
                <Example9_SearchMethods />
                <Example10_RealWorld />
            </div>
        );
    }
}
