# Design System Document: The Fluid Architect



This design system is a comprehensive framework for creating a high-end, editorial-inspired Memo and TODO experience. It moves beyond the "utility-first" look of standard productivity apps to embrace a "Fluid Architect" aesthetic—combining the structural precision of architectural drafting with the soft, tactile quality of premium digital stationery.



---



## 1. Overview & Creative North Star



**Creative North Star: The Digital Curator**

The goal is not just to "list tasks," but to "curate a day." This design system rejects the rigid, boxed-in grids of traditional productivity software. Instead, it utilizes **Intentional Asymmetry** and **Tonal Depth** to create a focused, high-end workspace.



By prioritizing white space and sophisticated layering over structural lines, we create an interface that feels like a quiet, well-lit studio. We use high-contrast editorial typography (Manrope) for headers to provide an authoritative voice, paired with the functional clarity of Inter for body content.



---



## 2. Colors & Surface Philosophy



This system utilizes a nuanced palette where blue is an accent of intelligence, not a blunt instrument.



### The "No-Line" Rule

**Explicit Instruction:** You are prohibited from using 1px solid borders for sectioning or containment.

Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` task list sitting on a `surface` background provides all the separation a user needs without the visual "noise" of a stroke.



### Surface Hierarchy & Nesting

Treat the UI as a series of physical layers, like stacked sheets of frosted glass.

- **Base:** `surface` (#faf9fe)

- **Primary Containers:** `surface-container-low` (#f3f3fa) for secondary content.

- **Elevated Items:** `surface-container-lowest` (#ffffff) for active task cards.

- **Nesting:** Always place a "High" container inside a "Low" container to create natural focus.



### The "Glass & Gradient" Rule

To elevate the experience, use **Glassmorphism** for floating elements (like the Bottom Navigation or FAB). Apply `surface-container-lowest` with 80% opacity and a `20px` backdrop-blur.

- **Signature Texture:** For primary action buttons, use a linear gradient from `primary` (#005bc4) to `primary-container` (#4388fd) at a 135-degree angle. This adds "soul" and depth that a flat hex code cannot achieve.



---



## 3. Typography



The system uses a dual-typeface strategy to balance editorial sophistication with functional readability.



* **Display & Headlines (Manrope):** Chosen for its geometric precision and modern "editorial" feel. Use `headline-lg` for daily summaries to make the user feel like the editor of their own life.

* **Body & Labels (Inter):** Chosen for its unparalleled legibility at small scales.



| Level | Token | Font | Size | Weight | Usage |

| :--- | :--- | :--- | :--- | :--- | :--- |

| **Display** | `display-md` | Manrope | 2.75rem | 700 | Large "Hero" date or progress % |

| **Headline**| `headline-sm`| Manrope | 1.5rem | 600 | Section headers (e.g., "Today") |

| **Title** | `title-md` | Inter | 1.125rem| 500 | Memo titles, Task descriptions |

| **Body** | `body-md` | Inter | 0.875rem| 400 | Notes and secondary metadata |

| **Label** | `label-sm` | Inter | 0.6875rem| 600 | Tag labels (All Caps) |



---



## 4. Elevation & Depth



We convey hierarchy through **Tonal Layering** rather than traditional drop shadows.



* **The Layering Principle:** Depth is achieved by "stacking." A `surface-container-lowest` card placed on a `surface-container` background creates a soft, natural lift.

* **Ambient Shadows:** If an element must float (e.g., a FAB or a Modal), use an extra-diffused shadow: `box-shadow: 0 12px 32px rgba(47, 50, 58, 0.06);`. The shadow color must be a tinted version of `on-surface`, never pure black.

* **The "Ghost Border":** If a border is required for accessibility, it must be the `outline-variant` token at **15% opacity**. 100% opaque borders are forbidden.



---



## 5. Components



### Task Items & Lists

* **No Dividers:** Forbid the use of horizontal lines. Use a `12` (3rem) spacing unit between logical groups and `2` (0.5rem) spacing between items.

* **Checkboxes:** Use `primary` for the checked state. The unchecked state should be a `2px` "Ghost Border" of `outline`. On check, use a subtle spring animation (Scale 0.9 -> 1.1 -> 1.0).



### Tag Chips

* **Styling:** Use `xl` (1.5rem) roundedness for a pill shape.

* **Colors:** Use `tertiary-container` (#e4ceff) or `secondary-container` (#dbe2f9). The text must use the `on-container` variant for high contrast.



### The "Curated" Calendar

* **Status Indicators:** Do not fill the date cell. Use a `4` (1rem) circular dot positioned below the date.

* **Done:** `primary` (representing your professional blue).

* **Partial:** `tertiary-fixed-dim` (#d6c0f0) for a sophisticated yellow/purple interplay.



### Floating Action Button (FAB)

* **Visual:** A large `xl` or `full` rounded square.

* **Surface:** Use the Signature Texture gradient.

* **Elevation:** Use the Ambient Shadow spec. Position it with `20` (5rem) padding from the bottom right to avoid crowding the content.



### Bottom Navigation

* **Glassmorphism:** Use a `surface-container-highest` background with 70% opacity and a heavy `backdrop-filter: blur(12px)`.

* **Active State:** Use a `primary` dot (4px) below the active icon, rather than a background highlight, to maintain a clean editorial look.



---



## 6. Do's and Don'ts



### Do

* **DO** use asymmetric layouts (e.g., larger left margins for headlines) to create a premium feel.

* **DO** use the `24` (6rem) spacing unit to separate major sections like "Calendar" from "Tasks."

* **DO** ensure that in Dark Mode, the `surface-container` shifts remain subtle to maintain the "frosted glass" look.



### Don't

* **DON'T** use 1px dividers to separate items in a list. Use vertical space.

* **DON'T** use high-saturation backgrounds for chips. Stick to the "soft pastel" intent by using the `container` color tokens.

* **DON'T** use standard "Drop Shadows." Only use the Ambient Shadow spec provided.

* **DON'T** use "Pure Black" (#000000) for text. Use `on-surface` (#2f323a) to keep the look high-end and readable.