with Ada.Text_IO;
use Ada.Text_IO;
with Unchecked_Conversion;
with Ada.Strings.Unbounded;

procedure Main is

  package IntIO is new Ada.Text_IO.Integer_IO(Integer);
  use IntIO;

   package ubString renames Ada.Strings.Unbounded;
   TransferString : ubString.Unbounded_String := ubString.Null_Unbounded_String;
   FIname : String (1..19);
   cnt : Integer := 1;
   Flength : Integer;
   InputFile : Ada.Text_IO.File_Type;
   OutputFile : Ada.Text_IO.File_Type;
   OFileName : String := "OutputFile.txt";
   Sstr : String(1..1);
   Dstr: String (1..1);

begin

   Put("Enter File name:");
   Get_line(FIname, FLength);
   ubString.Append(Source => TransferString, New_Item => FIname (1..Flength));
   declare
    Fname : String  := ubString.To_String(TransferString);
   begin

      Open( File => InputFile, Mode => In_File, Name => FName);

      declare
         Fline : String := Get_Line(InputFile);
         FItems : Integer := Integer'Value(Fline);
         Source : Boolean := True;
         matrix : array (1..FItems, 1..FItems) of Boolean := (others => (others=> False));
         Itemsarr : array (1..FItems) of String (1..1);
         PosX : Integer range 0..FItems := 0;
         PosY : Integer range 0..Fitems := 0;
      begin
         for I in Integer range 1..FItems loop
            Fline := Get_Line(InputFile);
            Itemsarr(cnt) := Fline;
            cnt := cnt+1;
         end loop;
         cnt :=1;
         <<WhileTop>>
         while not End_Of_File (InputFile) loop --reading file
            Fline := Get_Line(InputFile);
            if( Source = True) then
               Sstr := Fline;
               Source := False;
               goto WhileTop;
            else
               Dstr := Fline;
               Source := True;
            end if;

            for I in Integer range 1..FItems loop -- check to se what letter it is
               if (Sstr = Itemsarr(I)) then
                  PosX := I;
               elsif (Dstr = Itemsarr(I)) then
                  PosY := I;
               else
                  exit when ((posX /= 0) and (posY /= 0));
               end if;
            end loop;

            matrix(PosX, PosY) := True;
            PosY  := 0;
            PosX := 0;
         end loop;
         Close(InputFile);

         --warhsall's
         for I in Integer range 1..Fitems loop
            for J in Integer range 1..Fitems loop
               if (matrix(J,I) = True) then
                  for K in Integer range 1..FItems loop
                     matrix(J,K) := matrix(J,K) or matrix(I,K);
                  end loop;
               end if;
            end loop;
         end loop;

         --printing matrix
         Create(File => OutputFile, Mode => Out_File, Name => OFileName);
         Put(OutputFile,"  ");
         for I in Integer range 1..FItems loop
            Put(OutputFile, Itemsarr(I));
            Put(OutputFile, "     ");
         end loop;
         New_Line(OutputFile);
         for I in Integer range 1..FItems loop
            Put(OutputFile, Itemsarr(I));
            Put(OutputFile, " ");
            for J in Integer range 1..FItems loop
               if (matrix(I,J) = True) then
                  Put(OutputFile, "True  ");
               else
                  Put(OutputFile, "False ");
               end if;
            end loop;
            New_Line(OutputFile);
         end loop;
         Close(OutputFile);
      end;
   end;
   null;
end Main;
