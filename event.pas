unit event;

interface
uses  Classes;

Type
  TOnShow                      = Procedure of object;
  TOnButtonClick               = Procedure of object;
  TOnExit                      = Function (const cInt : Integer) : String of object;
  TOnKeyPress                  = Procedure (var Key: Word) of object;
implementation

end.
