from pathlib import Path
import xml.etree.ElementTree as ET


XML_PATH = Path(__file__).with_name("attributes_listing.xml")
HEADER = (
    "| Attribute                      | Description"
    "                                                                                                                                                                                                                                                                                                 "
)
SEPARATOR = "|----------------------------------|-----------------------------| "
ATTRIBUTE_WIDTH = 32
DESCRIPTION_WIDTH = 297


def main() -> None:
    root = ET.parse(XML_PATH).getroot()

    print(HEADER)
    print(SEPARATOR)

    for attribute in root.find("Attributes").findall("Attribute"):
        name = attribute.get("Name")
        description = attribute.get("Definition")
        if not name or not description:
            print("skipping", attribute.get("Name"))
            continue
        name = name.replace("_", r"\_")
        description = description.replace("_", r"\_")
        print(f"| {name:<{ATTRIBUTE_WIDTH}} | {description:<{DESCRIPTION_WIDTH}} |")


if __name__ == "__main__":
    main()
