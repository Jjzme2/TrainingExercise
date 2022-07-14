// //Extension is in this #class.prototype.name#
// String.prototype.toCamel = camelCase;
// String.prototype.hasNumber = containsNumber;
// String.prototype.isEmpty = isEmptyString;
// String.prototype.matches = isMatch;
// String.prototype.validEmail = isEmailFormat;
// String.prototype.hasLetter = containsLetter;
// String.prototype.meetsLengthReq = isLengthy;
// String.prototype.isZero = isZeroNumeric;
// String.prototype.Change = replaceWith;




// function camelCase(_string) 
// {
//     !_string?_string=this:null;

//     let output = "";
//     //if the first character is not space
//     if ( _string[0] !== ' ' ) {
//       output = _string.charAt(0).toUpperCase() + _string.slice(1);
//     }
//     // if the first character is space
//     else {
//       output = _string.charAt(1).toUpperCase() + _string.slice(2);
//     }    
//     return output;
// }

// function containsNumber(_string){
//     !_string?_string=this:null;

//     return /\d/.test(_string);
// }

// function isEmptyString(_string){
//     !_string?_string=this:null;
    
//     if (_string == "" || _string == null) {return true;}
//         else{return false;}
// }


// function isMatch(checkForMatch, checkAgainstThis){
//     !checkAgainstThis?checkAgainstThis=this:null;

//     if(checkForMatch == checkAgainstThis){return true;}
//     else{return false;}
// }

// function containsLetter(_string){
//     !_string?_string=this:null;
//     return isNaN(_string);
// }

// function isEmailFormat(_string){
//     !_string?_string=this:null;
//     return /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i.test(_string);
// }

// function isLengthy(minLength, _string, maxLength){
//     !_string?_string=this:null;
//     !maxLength?maxLength=256:null;

//     if(_string.length >= minLength && _string.length < maxLength){return true;}
//     else{return false;}
// }

// function replaceWith(replacement, stringToReplace){
//     !stringToReplace?stringToReplace=this:null;

//     stringToReplace = replacement;
//     return replacement;
// }


// function isZeroNumeric(_string){
//     !_string?_string=this:null;
    
//     if(_string + 0 == 0){
//         return true;
//     }else{
//         return false;
//     }
// }