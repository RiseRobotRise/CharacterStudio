@tool
class_name GadgetQuat
extends GadgetVector4

static func supports_type(value) -> bool:
	return value is Quaternion
