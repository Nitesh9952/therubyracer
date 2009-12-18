#ifndef _RUBY_V8_OBJECT_
#define _RUBY_V8_OBJECT_ 

#include "ruby.h"

extern VALUE V8_C_Object;

VALUE v8_Object_New(VALUE clazz);
VALUE v8_Object_Get(VALUE self, VALUE key);
VALUE v8_Object_Set(VALUE self, VALUE key, VALUE value);
#endif