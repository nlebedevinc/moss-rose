use std::collections::HashMap;
use std::fmt;

/// A named set of colors.
#[derive(Debug, Clone, PartialEq)]
pub struct Theme<'a> {
    pub name: &'a str,
    colors: HashMap<String, u32>,
}

#[derive(Debug)]
pub enum ThemeError {
    Missing(String),
    Invalid { key: String, value: String },
}

impl<'a> Theme<'a> {
    pub fn new(name: &'a str) -> Self {
        Self { name, colors: HashMap::new() }
    }

    pub fn get(&self, key: &str) -> Result<u32, ThemeError> {
        match self.colors.get(key) {
            Some(&rgb) if rgb <= 0xFF_FFFF => Ok(rgb),
            Some(other) => Err(ThemeError::Invalid { key: key.into(), value: format!("{other:#x}") }),
            None => Err(ThemeError::Missing(key.to_owned())),
        }
    }
}

impl fmt::Display for Theme<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{} ({} colors)", self.name, self.colors.len())
    }
}
