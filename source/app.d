import ui;
import std.stdio;

uiControl* toControl(T)(T control)
{
	return cast(uiControl*) control;
}

import std.conv;

extern (C) void print(uiButton* b, void* t)
{
	string text = uiEntryText(cast(uiEntry*) t).to!string;
	writeln(text);
}

uiWindow* mainWindow()
{
	auto input1 = uiNewEntry();
	auto input2 = uiNewEntry();
	auto input3 = uiNewEntry();

	auto form = uiNewForm();
	uiFormSetPadded(form, true);
	uiFormAppend(form, "text ot print", input1.toControl, false);
	uiFormAppend(form, "input2", input2.toControl, false);
	uiFormAppend(form, "input3", input3.toControl, false);

	auto btnSubmit = uiNewButton("Print");
	uiButtonOnClicked(btnSubmit, &print, input1);

	auto buttons = uiNewHorizontalBox();
	uiBoxSetPadded(buttons, true);
	uiBoxAppend(buttons, btnSubmit.toControl, true);

	auto root = uiNewVerticalBox();
	uiBoxSetPadded(root, true);
	uiBoxAppend(root, form.toControl, true);
	uiBoxAppend(root, buttons.toControl, false);

	auto w = uiNewWindow("Hewwo", 1, 1, false);
	uiWindowSetMargined(w, true);
	uiWindowOnClosing(w, (_w, _data) { uiQuit(); return true; }, null);
	uiWindowSetChild(w, root.toControl);
	return w;
}

int main()
{
	uiInitOptions o;
	// assert(uiInit(&o));
	auto error = uiInit(&o);
	if (error)
	{
		writeln(error);
		return 1;
	}
	auto w = mainWindow();
	uiControlShow(w.toControl);
	uiMain();
	writeln("Done");
	return 0;
}
