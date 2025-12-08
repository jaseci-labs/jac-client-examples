# ============================================
# JAC-LANG CONDITIONAL RENDERING EXAMPLES
# Equivalent to React patterns
# ============================================

# Import React hooks
cl import from react {useState, useEffect}

# Styles object for consistent styling


cl {
    let styles = {
    "box": {
        "padding": "15px",
        "backgroundColor": "#f8f9fa",
        "borderRadius": "8px",
        "border": "1px solid #dee2e6",
        "marginBottom": "10px"
    },
    "section": {
        "marginBottom": "30px",
        "borderBottom": "1px solid #eee",
        "paddingBottom": "20px"
    },
    "title": {
        "color": "#333",
        "borderLeft": "4px solid #007bff",
        "paddingLeft": "10px",
        "marginBottom": "15px"
    },
    "button": {
        "padding": "8px 16px",
        "marginRight": "10px",
        "backgroundColor": "#007bff",
        "color": "white",
        "border": "none",
        "borderRadius": "4px",
        "cursor": "pointer"
    }
};
    # ============================================
    # 1. IF/ELSE WITH EARLY RETURN
    # ============================================
    def IfElseExample(props: dict) -> any {
        let isLoggedIn = props.isLoggedIn;
        if isLoggedIn {
            return <div style={styles["box"]}>✅ Welcome back, User!</div>;
        }
        return <div style={styles["box"]}>🔒 Please sign in.</div>;
    }

    # ============================================
    # 2. TERNARY OPERATOR (Python-style: x if condition else y)
    # ============================================
    def TernaryExample(props: dict) -> any {
        let isOnline = props.isOnline;
        return (
            <div style={styles["box"]}>
                Status: {(<span style={{ color: "green" }}>🟢 Online</span>) if isOnline else (<span style={{ color: "red" }}>🔴 Offline</span>)}
            </div>
        );
    }

    # ============================================
    # 3. COMPLEX TERNARY (Chained if-else)
    # ============================================
    def ComplexTernaryExample(props: dict) -> any {
        let condition1 = props.condition1;
        let condition2 = props.condition2;
        return (
            <div style={styles["box"]}>
                {(<span style={{ color: "green" }}>✅ Condition 1 is true</span>) if condition1 else ((<span style={{ color: "blue" }}>🔵 Condition 2 is true</span>) if condition2 else (<span style={{ color: "gray" }}>⚪ Both conditions are false</span>))}
            </div>
        );
    }

    # ============================================
    # 4. LOGICAL AND (&&) OPERATOR
    # ============================================
    def LogicalAndExample(props: dict) -> any {
        let hasNotifications = props.hasNotifications;
        let count = props.count;
        return (
            <div style={styles["box"]}>
                <span>Notifications: </span>
                {hasNotifications and count > 0 and (
                    <span style={{ color: "blue", fontWeight: "bold" }}>
                        🔔 You have {count} new messages!
                    </span>
                )}
                {not hasNotifications and <span>No new notifications</span>}
            </div>
        );
    }

    # ============================================
    # 5. LOGICAL OR (||) - DEFAULT VALUES
    # ============================================
    def LogicalOrExample(props: dict) -> any {
        let username = props.username;
        return (
            <div style={styles["box"]}>
                Hello, <strong>{username or "Guest"}</strong>! 👋
            </div>
        );
    }

    # ============================================
    # 6. NULLISH COALESCING EQUIVALENT
    # In Jac, use "or" or explicit None check
    # ============================================
    # def NullishCoalescingExample(props: dict) -> any {
    #     let value = props.value;
    #     # Using explicit check for None
    #     let displayValue = value if value is not None else "No value provided";
    #     return (
    #         <div style={styles["box"]}>
    #             Value: <strong>{displayValue}</strong>
    #             <br />
    #             <small>(Shows default only for None, not 0 or empty string)</small>
    #         </div>
    #     );
    # }

    # ============================================
    # 7. SWITCH STATEMENT
    # ============================================
    #  SWITCH DOESN'T SUPPORT NOW
    # def SwitchExample(props: dict) -> any {
    #     let status = props.status;

    #     def renderStatus() -> any {
    #         switch status {
    #             case "success":
    #                 return <span style={{ color: "green" }}>✅ Success!</span>;
    #             case "error":
    #                 return <span style={{ color: "red" }}>❌ Error occurred</span>;
    #             case "loading":
    #                 return <span style={{ color: "orange" }}>⏳ Loading...</span>;
    #             case "pending":
    #                 return <span style={{ color: "blue" }}>⏸️ Pending</span>;
    #             default:
    #                 return <span>❓ Unknown status</span>;
    #         }
    #     }

    #     return <div style={styles["box"]}>Status: {renderStatus()}</div>;
    # }

    # ============================================
    # 8. OBJECT LOOKUP / MAPPING
    # ============================================
    def ObjectLookupExample(props: dict) -> any {
        let theme = props.theme;
        let themes = {
            "light": { "bg": "#ffffff", "text": "#000000", "emoji": "☀️" },
            "dark": { "bg": "#333333", "text": "#ffffff", "emoji": "🌙" },
            "sepia": { "bg": "#f4ecd8", "text": "#5c4033", "emoji": "📜" }
        };

        let currentTheme = themes[theme] if theme in themes else themes["light"];

        return (
            <div style={{
                padding: "15px",
                borderRadius: "8px",
                border: "1px solid #dee2e6",
                marginBottom: "10px",
                backgroundColor: currentTheme["bg"],
                color: currentTheme["text"]
            }}>
                {currentTheme["emoji"]} Current Theme: <strong>{theme or "light"}</strong>
            </div>
        );
    }

    # ============================================
    # 9. MULTIPLE IF-ELIF-ELSE (Like IIFE in React)
    # ============================================
    def MultipleConditionsIfElse(props: dict) -> any {
        let user = props.user;

        def getUserAccess() -> any {
            if not user {
                return <span>👤 No user - Please login</span>;
            }
            if user["role"] == "admin" {
                return <span>👑 Admin Dashboard Access</span>;
            }
            if user["role"] == "moderator" {
                return <span>🛡️ Moderator Access</span>;
            }
            if user["role"] == "member" {
                return <span>👥 Member Access</span>;
            }
            return <span>👋 Guest Access</span>;
        }

        return <div style={styles["box"]}>{getUserAccess()}</div>;
    }

    # ============================================
    # 10. RENDERING NOTHING (empty fragment)
    # ============================================
    def RenderNothingExample(props: dict) -> any {
        let shouldShow = props.shouldShow;
        if not shouldShow {
            return <></>;  # Renders nothing (empty fragment)
        }
        return <div style={styles["box"]}>🎉 I'm visible because shouldShow is true!</div>;
    }

    # ============================================
    # 11. CONDITIONAL CSS CLASSES
    # ============================================
    def ConditionalClassesExample(props: dict) -> any {
        let isActive = props.isActive;
        let isPrimary = props.isPrimary;

        # Build class string conditionally
        let baseClass = "btn";
        let activeClass = " active" if isActive else "";
        let colorClass = " primary" if isPrimary else " secondary";
        let buttonClasses = baseClass + activeClass + colorClass;

        let cssStyles = ".btn { padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin: 5px; } .active { box-shadow: 0 0 10px rgba(0,0,0,0.3); transform: scale(1.05); } .primary { background-color: #007bff; color: white; } .secondary { background-color: #6c757d; color: white; }";

        return (
            <div style={styles["box"]}>
                <style>{cssStyles}</style>
                <button className={buttonClasses}>
                    {("✓ Active") if isActive else ("Inactive")} {("Primary") if isPrimary else ("Secondary")} Button
                </button>
                <br />
                <small>Classes: {buttonClasses}</small>
            </div>
        );
    }

    # ============================================
    # 12. CONDITIONAL ATTRIBUTES/PROPS
    # ============================================
    def ConditionalAttributesExample(props: dict) -> any {
        let isDisabled = props.isDisabled;
        let isRequired = props.isRequired;

        let placeholder = ("* Enter your name") if isRequired else ("Enter your name");

        return (
            <div style={styles["box"]}>
                <input
                    type="text"
                    placeholder={placeholder}
                    disabled={isDisabled}
                    required={isRequired}
                    style={{
                        padding: "8px",
                        opacity: (0.5) if isDisabled else (1),
                        border: ("2px solid red") if isRequired else ("1px solid gray")
                    }}
                />
                <br />
                <small>
                    Disabled: {("Yes") if isDisabled else ("No")} | Required: {("Yes") if isRequired else ("No")}
                </small>
            </div>
        );
    }

    # ============================================
    # 13. LIST CONDITIONAL RENDERING
    # ============================================
    def ListConditionalExample(props: dict) -> any {
        let items = props.items;

        if not items or items.length == 0 {
            return <div style={styles["box"]}>📭 No items found.</div>;
        }

        def renderItem(item: any, index: int) -> any {
            return <li key={index}>{item}</li>;
        }

        return (
            <div style={styles["box"]}>
                <strong>📋 Items List:</strong>
                <ul style={{ margin: "10px 0", paddingLeft: "20px" }}>
                    {items.map(renderItem)}
                </ul>
            </div>
        );
    }

    # ============================================
    # 14. CONDITIONAL WITH FRAGMENTS
    # ============================================
    def FragmentsExample(props: dict) -> any {
        let user = props.user;
        let showDetails = props.showDetails;

        let userName = user["name"] if user else "Anonymous";

        return (
            <div style={styles["box"]}>
                <strong>👤 {userName}</strong>
                {showDetails and user and (
                    <>
                        <br />
                        <span>📧 Email: {user["email"]}</span>
                        <br />
                        <span>📱 Phone: {user["phone"]}</span>
                    </>
                )}
                {not showDetails and <span> (Click to show details)</span>}
            </div>
        );
    }

    # ============================================
    # 15. MULTIPLE CONDITIONS COMBINED (Loading/Error/Data)
    # ============================================
    def MultipleConditionsExample(props: dict) -> any {
        let isLoading = props.isLoading;
        let error = props.error;
        let data = props.data;

        return (
            <div style={styles["box"]}>
                {isLoading and <span>⏳ Loading data...</span>}
                {not isLoading and error and <span style={{ color: "red" }}>❌ Error: {error}</span>}
                {not isLoading and not error and data and <span style={{ color: "green" }}>✅ Data: {data}</span>}
                {not isLoading and not error and not data and <span>📭 No data available</span>}
            </div>
        );
    }

    # ============================================
    # 16. INTERACTIVE STATE EXAMPLE (with useState)
    # ============================================
    def InteractiveExample(props: dict) -> any {
        let (isVisible, setIsVisible) = useState(False);
        let (count, setCount) = useState(0);

        return (
            <div style={styles["box"]}>
                <div style={{ marginBottom: "10px" }}>
                    <button onClick={lambda: setIsVisible(not isVisible)} style={styles["button"]}>
                        {("Hide") if isVisible else ("Show")} Content
                    </button>
                    <button onClick={lambda: setCount(count + 1)} style={styles["button"]}>
                        Increment ({count})
                    </button>
                </div>

                {isVisible and (
                    <div style={{
                        padding: "10px",
                        backgroundColor: "#e8f5e9",
                        borderRadius: "5px"
                    }}>
                        🎉 Hidden content is now visible!
                        {count > 5 and (
                            <div style={{ color: "blue" }}>
                                ⭐ Bonus: Count is greater than 5!
                            </div>
                        )}
                    </div>
                )}
            </div>
        );
    }

    # ============================================
    # 17. ENUM-BASED RENDERING
    # ============================================
    def EnumBasedExample(props: dict) -> any {
        let currentPage = props.currentPage;

        let pageContent = {
            "home": { "icon": "🏠", "title": "Home Page", "content": "Welcome to our website!" },
            "about": { "icon": "📖", "title": "About Us", "content": "Learn more about our company." },
            "contact": { "icon": "📞", "title": "Contact", "content": "Get in touch with us." },
            "settings": { "icon": "⚙️", "title": "Settings", "content": "Customize your preferences." }
        };

        let defaultPage = { "icon": "❓", "title": "Not Found", "content": "Page not found." };
        let page = pageContent[currentPage] if currentPage in pageContent else defaultPage;

        return (
            <div style={styles["box"]}>
                <h4>{page["icon"]} {page["title"]}</h4>
                <p>{page["content"]}</p>
            </div>
        );
    }

    # ============================================
    # MAIN APP COMPONENT
    # ============================================
    def app() -> any {
        return (
            <div style={{
                fontFamily: "Arial, sans-serif",
                maxWidth: "800px",
                margin: "0 auto",
                padding: "20px"
            }}>
                <h1 style={{ textAlign: "center", color: "#333" }}>
                    🎯 JAC-Lang Conditional Rendering Examples
                </h1>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>1. If/Else with Early Return</h3>
                    <IfElseExample isLoggedIn={True} />
                    <IfElseExample isLoggedIn={False} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>2. Ternary Operator (Python-style)</h3>
                    <TernaryExample isOnline={True} />
                    <TernaryExample isOnline={False} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>3. Complex Ternary (Chained If-Else)</h3>
                    <ComplexTernaryExample condition1={True} condition2={False} />
                    <ComplexTernaryExample condition1={False} condition2={True} />
                    <ComplexTernaryExample condition1={False} condition2={False} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>4. Logical AND (and) Operator</h3>
                    <LogicalAndExample hasNotifications={True} count={5} />
                    <LogicalAndExample hasNotifications={False} count={0} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>5. Logical OR (or) - Default Values</h3>
                    <LogicalOrExample username="John Doe" />
                    <LogicalOrExample username="" />
                    <LogicalOrExample username={None} />
                </div>

                # <div style={styles["section"]}>
                #     <h3 style={styles["title"]}>6. Nullish Coalescing (None check)</h3>
                #     <NullishCoalescingExample value="Hello World" />
                #     <NullishCoalescingExample value={0} />
                #     <NullishCoalescingExample value={None} />
                # </div>

                # <div style={styles["section"]}>
                #     <h3 style={styles["title"]}>7. Switch Statement</h3>
                #     <SwitchExample status="success" />
                #     <SwitchExample status="error" />
                #     <SwitchExample status="loading" />
                #     <SwitchExample status="pending" />
                # </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>8. Object Lookup / Mapping</h3>
                    <ObjectLookupExample theme="light" />
                    <ObjectLookupExample theme="dark" />
                    <ObjectLookupExample theme="sepia" />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>9. Multiple If-Elif-Else (User Roles)</h3>
                    <MultipleConditionsIfElse user={None} />
                    <MultipleConditionsIfElse user={{ "role": "admin" }} />
                    <MultipleConditionsIfElse user={{ "role": "moderator" }} />
                    <MultipleConditionsIfElse user={{ "role": "member" }} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>10. Rendering Nothing (None)</h3>
                    <RenderNothingExample shouldShow={True} />
                    <RenderNothingExample shouldShow={False} />
                    <small>👆 Second component renders nothing (None)</small>
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>11. Conditional CSS Classes</h3>
                    <ConditionalClassesExample isActive={True} isPrimary={True} />
                    <ConditionalClassesExample isActive={False} isPrimary={False} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>12. Conditional Attributes/Props</h3>
                    <ConditionalAttributesExample isDisabled={False} isRequired={True} />
                    <ConditionalAttributesExample isDisabled={True} isRequired={False} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>13. List Conditional Rendering</h3>
                    <ListConditionalExample items={["Apple", "Banana", "Cherry"]} />
                    <ListConditionalExample items={[]} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>14. Conditional with Fragments</h3>
                    <FragmentsExample
                        user={{ "name": "John", "email": "john@example.com", "phone": "123-456-7890" }}
                        showDetails={True}
                    />
                    <FragmentsExample
                        user={{ "name": "Jane", "email": "jane@example.com", "phone": "098-765-4321" }}
                        showDetails={False}
                    />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>15. Multiple Conditions Combined</h3>
                    <MultipleConditionsExample isLoading={True} error={None} data={None} />
                    <MultipleConditionsExample isLoading={False} error="Network error" data={None} />
                    <MultipleConditionsExample isLoading={False} error={None} data="Success data!" />
                    <MultipleConditionsExample isLoading={False} error={None} data={None} />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>16. Interactive State Example</h3>
                    <InteractiveExample />
                </div>

                <div style={styles["section"]}>
                    <h3 style={styles["title"]}>17. Enum-Based Rendering</h3>
                    <EnumBasedExample currentPage="home" />
                    <EnumBasedExample currentPage="about" />
                    <EnumBasedExample currentPage="contact" />
                    <EnumBasedExample currentPage="unknown" />
                </div>
            </div>
        );
    }
}

