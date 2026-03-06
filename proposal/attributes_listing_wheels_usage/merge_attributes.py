#!/usr/bin/env python3
"""
Merge gdtf_attributes_with_description.json into attributes_listing.xml
based on Attribute Name.

Rules:
- Match JSON _name to XML Attribute@Name.
- Map fields:
  _name -> Name
  _prettyName -> Pretty
  _feature -> Feature
  _physicalUnit -> PhysicalUnit
  definition -> Definition
  explanation -> Explanation
  _label -> Label
- Keep all other XML attributes and structure.
- JSON values overwrite existing XML values when non-empty.
- Reformat output with a custom formatter (2-space indent).
"""

import json
from pathlib import Path
import xml.etree.ElementTree as ET

JSON_PATH = Path("gdtf_attributes_with_description.json")
XML_PATH = Path("attributes_listing.xml")

MAP_FIELDS = {
    "_name": "Name",
    "_prettyName": "Pretty",
    "_feature": "Feature",
    "_physicalUnit": "PhysicalUnit",
    "definition": "Definition",
    "explanation": "Explanation",
    "_label": "Label",
}

DEFAULT_ATTRS = {
    "UseEmmiter": "False",
    "UseFilter": "False",
    "UseWheel": "False",
    "UseWheelSlot": "False",
    "UseGamut": "False",
    "UseColorSpace": "False",
}


def load_json(path: Path):
    obj = json.loads(path.read_text(encoding="utf-8"))
    if isinstance(obj, dict) and "Attribute" in obj:
        items = obj["Attribute"]
    elif isinstance(obj, list):
        items = obj
    else:
        raise ValueError("Unexpected JSON structure")
    if not isinstance(items, list):
        raise ValueError("JSON 'Attribute' is not a list")
    return items


def build_index(items):
    by_name = {}
    for it in items:
        name = it.get("_name")
        if name:
            by_name[name] = it
    return by_name


def merge(xml_path: Path, by_name):
    tree = ET.parse(xml_path)
    root = tree.getroot()

    updated = 0
    matched = 0
    missing_in_json = []

    for attr in root.findall(".//Attribute"):
        name = attr.get("Name")
        if not name:
            continue
        data = by_name.get(name)
        if not data:
            missing_in_json.append(name)
            continue
        matched += 1
        for jkey, xkey in MAP_FIELDS.items():
            if jkey not in data:
                continue
            val = data.get(jkey)
            if val is None or val == "":
                continue
            val = str(val)
            if attr.get(xkey) != val:
                attr.set(xkey, val)
                updated += 1
        for xkey, val in DEFAULT_ATTRS.items():
            if attr.get(xkey) != val:
                attr.set(xkey, val)
                updated += 1

    return tree, root, matched, updated, missing_in_json


def xml_escape(text: str) -> str:
    return (
        text.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace('"', "&quot;")
    )


def format_custom(root: ET.Element, indent: str = "  ") -> str:
    lines = ["<?xml version=\"1.0\"?>"]

    def write_elem(elem: ET.Element, level: int) -> None:
        pad = indent * level
        tag = elem.tag
        attrs = elem.attrib
        children = list(elem)
        text = (elem.text or "").strip()

        if attrs:
            lines.append(f"{pad}<{tag}")
            for k, v in attrs.items():
                lines.append(f"{pad}{indent}{k}=\"{xml_escape(str(v))}\"")
        else:
            lines.append(f"{pad}<{tag}")

        if children or text:
            lines[-1] = lines[-1] + ">"
            if text:
                lines.append(f"{pad}{indent}{xml_escape(text)}")
            for child in children:
                write_elem(child, level + 1)
                if child.tail and child.tail.strip():
                    lines.append(f"{pad}{indent}{xml_escape(child.tail.strip())}")
            lines.append(f"{pad}</{tag}>")
        else:
            lines[-1] = lines[-1] + "/>"

    write_elem(root, 0)
    return "\n".join(lines) + "\n"


def main():
    items = load_json(JSON_PATH)
    by_name = build_index(items)

    tree, root, matched, updated, missing_in_json = merge(XML_PATH, by_name)

    formatted = format_custom(root)
    XML_PATH.write_text(formatted, encoding="utf-8")

    print(f"matched {matched} attributes; updated {updated} fields")
    print(f"missing in json: {len(missing_in_json)}")


if __name__ == "__main__":
    main()
