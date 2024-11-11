## Background

CoreText, part of Apple’s text rendering system, has exhibited a memory retention issue when handling emoji characters in keyboard extensions, which can lead to increased memory usage. While this issue may not impact most iOS applications, it poses significant challenges in custom third-party keyboard extensions.

After extensive debugging, the presented solution minimizes this memory impact, providing a practical example for iOS developers working on keyboard extensions.

This repository provides a sample project showcasing a solution for a persistent memory issue in iOS keyboard extensions, specifically related to CoreText's handling of emoji rendering. The problem, affecting iOS keyboard extensions since 2014, is addressed here with in-depth debugging insights and a unique fix implemented in Swift.

## Medium Post

For a detailed breakdown of the problem, the solution, and insights into the debugging process, check out the full article on Medium:

**[How I Solved CoreText Emoji Rendering Memory Issues for iOS Keyboard Extensions - Medium](https://medium.com/@mohasalah/core-text-emoji-rendering-memory-issue-1c6a227d592d)**

## Project Structure

- **EmojiTest**: The main app target with a test view controller to replicate the memory behavior.
- **Keyboard Extension**: A separate target simulating real-world scenarios for emoji rendering in custom keyboard extensions.

Happy debugging and coding!
